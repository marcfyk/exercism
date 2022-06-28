defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number
    |> parse()
    |> validate_length()
    |> validate_digits()
    |> Kernel.==(:ok)
  end

  defp parse(number) do
    if String.match?(number, ~r/^[\d\s]+$/), do: {:ok, number}, else: :error
  end

  defp validate_length(:error), do: :error
  defp validate_length({:ok, number}) do
    number
    |> String.graphemes()
    |> Stream.filter(&String.match?(&1, ~r/\d/))
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
    |> fn digits -> if Enum.count(digits) > 1, do: {:ok, digits}, else: :error end.()
  end

  defp validate_digits(:error), do: :error
  defp validate_digits({:ok, digits}) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {n, index} -> if rem(index, 2) == 1, do: n * 2, else: n end)
    |> Enum.map(fn n -> if n > 9, do: n - 9, else: n end)
    |> Enum.sum()
    |> fn sum -> if rem(sum, 10) == 0, do: :ok, else: :error end.()
  end

end
