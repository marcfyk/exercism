defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    1..radicand
    |> Stream.filter(&(&1 ** 2 == radicand))
    |> Enum.take(1)
    |> hd()
  end
end
