defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input), do: calc(input, 0)
  defp calc(1, count), do: count
  defp calc(n, count) when is_integer(n) and n >= 1 and rem(n, 2) == 0, do: calc(div(n, 2), count + 1)
  defp calc(n, count) when is_integer(n) and n >= 1, do: calc(n * 3 + 1, count + 1)
end
