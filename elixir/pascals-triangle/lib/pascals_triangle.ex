defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    rows(1, num, [[1]])
  end

  defp rows(index, limit, acc) when index == limit, do: acc |> Enum.reverse()
  defp rows(index, limit, [h | _] = acc) when index < limit do
    rows(index + 1, limit, [new_row(h) | acc])
  end

  defp new_row([]), do: [1]
  defp new_row(row) do
    middle = row
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.map(&Enum.sum/1)
    1..1
    |> Stream.concat(middle)
    |> Stream.concat(1..1)
    |> Enum.to_list()
  end

end
