defmodule Matrix do
  defstruct [:grid, :r, :c]

  def parse(input) do
    grid = input
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&List.to_tuple/1)
    |> List.to_tuple()
    r = grid |> tuple_size()
    c = if r == 0, do: 0, else: grid |> elem(0) |> tuple_size()
    %Matrix{grid: grid, r: r, c: c}
  end

  def get(matrix, {i, j}), do: matrix.grid |> elem(i) |> elem(j)

  def adjacent(matrix, {i, j}) do
    for x <- i - 1 .. i + 1,
        y <- j - 1 .. j + 1,
        x != i or y != j,
        0 <= x and x < matrix.r,
        0 <= y and y < matrix.c, do: {x, y}
  end

end
defmodule Minesweeper do
  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t()]) :: [String.t()]

  def annotate(board) do
    board
    |> Matrix.parse()
    |> build_list_matrix()
    |> Enum.map(&Enum.join(&1, ""))
  end

  defp build_list_matrix(%Matrix{grid: _, r: 0, c: 0}), do: []
  defp build_list_matrix(%Matrix{grid: _, r: r, c: 0}), do: Stream.repeatedly(fn -> [] end) |> Enum.take(r)
  defp build_list_matrix(matrix) do
    for i <- 0 .. matrix.r - 1,
        j <- 0 .. matrix.c - 1 do
          {i, j}
        end
    |> Enum.map(&get_value(matrix, &1))
    |> Enum.chunk_every(matrix.c)
  end

  defp get_value(matrix, position) do
    case Matrix.get(matrix, position) do
      " " ->
        count = matrix
        |> Matrix.adjacent(position)
        |> Enum.filter(&(Matrix.get(matrix, &1) == "*"))
        |> Enum.count()
        case count do
          0 -> " "
          _ -> count |> Integer.to_string()
        end
      value -> value
    end
  end

end
