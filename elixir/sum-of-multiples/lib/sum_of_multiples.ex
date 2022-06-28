defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    0..limit - 1
    |> Stream.filter(&(multiple?(factors, &1)))
    |> Stream.take(limit)
    |> Enum.sum
  end

  defp multiple?(factors, 0), do: 0 in factors
  defp multiple?(factors, n) do
    factors
    |> Stream.filter(&(&1 > 0))
    |> Enum.any?(&(rem(n, &1) == 0))
  end
end
