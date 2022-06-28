defmodule Matrix do
  defstruct [:matrix, :r, :c]
  def parse(input) do
    matrix = input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&List.to_tuple/1)
    |> List.to_tuple()
    r = matrix |> tuple_size()
    c = if r == 0, do: 0, else: matrix |> elem(0) |> tuple_size()
    %__MODULE__{matrix: matrix, r: r, c: c}
  end

  def get(matrix, {i, j}), do: matrix.matrix |> elem(i) |> elem(j)
end
defmodule Rectangles do
  @doc """
  Count the number of ASCII rectangles.
  """
  @spec count(input :: String.t()) :: integer
  def count(""), do: 0
  def count(input) do
    matrix = input |> Matrix.parse()
    matrix
    |> vertices()
    |> count_rectangles(matrix, 0)
  end

  defp vertices(matrix) do
    for i <- 0 .. matrix.r - 1,
        j <- 0 .. matrix.c - 1,
        Matrix.get(matrix, {i, j}) == "+",
        do: {i, j}
  end

  defp count_rectangles([], _, count), do: count
  defp count_rectangles(vertices, matrix, count) do
    c = vertices
    |> get_rectangles(matrix)
    |> Enum.count()
    count_rectangles(tl(vertices), matrix, count + c)
  end

  defp get_rectangles(vertices, _)
  defp get_rectangles([], _), do: []
  defp get_rectangles([_], _), do: []
  defp get_rectangles([_, _], _), do: []
  defp get_rectangles([_, _, _], _), do: []
  defp get_rectangles([a | rest], matrix) do
    for b <- rest,
        c <- rest,
        d <- rest,
        [b, c, d] |> Enum.uniq() |> Enum.count() |> Kernel.==(3),
        left_and_right?(a, b, matrix),
        left_and_right?(c, d, matrix),
        up_and_down?(a, c, matrix),
        up_and_down?(b, d, matrix),
        do: {a, b, c, d}
  end

  defp left_and_right?({x1, y1}, {x2, y2}, matrix) when x1 == x2 do
    cond do
      y1 == (y2 - 1) -> true
      y1 < y2 ->
        y1+1..y2-1
        |> Enum.map(&Matrix.get(matrix, {x1, &1}))
        |> Enum.all?(&(&1 == "-" or &1 == "+"))
      true -> false
    end
  end
  defp left_and_right?(_, _, _), do: false

  defp up_and_down?({x1, y1}, {x2, y2}, matrix) when y1 == y2 do
    cond do
      x1 == (x2 - 1) -> true
      x1 < x2 ->
        x1 + 1 .. x2 - 1
        |> Enum.map(&Matrix.get(matrix, {&1, y1}))
        |> Enum.all?(&(&1 == "|" or &1 == "+"))
      true -> false
    end
  end
  defp up_and_down?(_, _, _), do: false

end
