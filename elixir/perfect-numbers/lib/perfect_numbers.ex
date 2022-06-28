defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1, do: {:error, "Classification is only possible for natural numbers."}
  def classify(number) do
    result = aliquot_sum(number)
    cond do
      result > number -> {:ok, :abundant}
      result < number -> {:ok, :deficient}
      result == number -> {:ok, :perfect}
    end
  end

  defp aliquot_sum(n) do
    n
    |> factors()
    |> Enum.sum()
  end

  defp factors(n), do: get_factors(n, 1, [])
  defp get_factors(n, index, acc) when index == n, do: acc
  defp get_factors(n, index, acc) when rem(n, index) == 0, do: get_factors(n, index + 1, [index | acc])
  defp get_factors(n, index, acc) when rem(n, index) > 0, do: get_factors(n, index + 1, acc)
end
