defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []
  def matrix(dimension) do
    build(1, dimension, dimension)
    |> Stream.map(&Enum.to_list/1)
    |> Enum.to_list()
  end

  defp build(_, _, 0), do: [[]]
  defp build(index, r, c) do
    head = index..index + c - 1
    |> Stream.map(&(&1))
    tail = build(index + c, c, r - 1)
    |> Stream.zip()
    |> Stream.map(&Tuple.to_list/1)
    |> Stream.map(&Enum.reverse/1)
    Stream.concat([head], tail)
  end

end
