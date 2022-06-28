defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1
  def largest_product(_, size) when size < 0, do: raise ArgumentError
  def largest_product(number_string, size) do
    if String.length(number_string) < size, do: raise ArgumentError
    number_string
    |> String.graphemes()
    |> Stream.map(&Integer.parse/1)
    |> Stream.map(&elem(&1, 0))
    |> Stream.chunk_every(size, 1, :discard)
    |> Stream.map(&Enum.reduce(&1, 1, fn c, acc -> c * acc end))
    |> Enum.max()
  end
end
