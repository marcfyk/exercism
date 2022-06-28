defmodule HexMatrix do
  defstruct [:grid, :r, :c]

  def parse(input) do
    grid = input
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&List.to_tuple/1)
    |> List.to_tuple()
    r = grid |> tuple_size()
    c = if r == 0, do: 0, else: grid |> elem(0) |> tuple_size()
    %HexMatrix{grid: grid, r: r, c: c}
  end

  def get(hexmatrix, {i, j}), do: hexmatrix.grid |> elem(i) |> elem(j)

  def adjacent(hexmatrix, {i, j}) do
    [
      {i - 1, j}, {i - 1, j + 1},
      {i, j - 1}, {i, j + 1},
      {i + 1, j - 1}, {i + 1, j}
    ]
    |> Enum.filter(fn {i, _} -> 0 <= i and i < hexmatrix.r end)
    |> Enum.filter(fn {_, j} -> 0 <= j and j < hexmatrix.c end)
  end

  def top_positions(hexmatrix), do: 0..hexmatrix.c - 1 |> Enum.map(&{0, &1})
  def bot_positions(hexmatrix), do: 0..hexmatrix.c - 1 |> Enum.map(&{hexmatrix.r - 1, &1})
  def left_positions(hexmatrix), do: 0..hexmatrix.r - 1 |> Enum.map(&{&1, 0})
  def right_positions(hexmatrix), do: 0..hexmatrix.r - 1 |> Enum.map(&{&1, hexmatrix.c - 1})

end

defmodule Connect do

  @white "O"
  @black "X"

  @doc """
  Calculates the winner (if any) of a board
  using "O" as the white player
  and "X" as the black player
  """
  @spec result_for([String.t()]) :: :none | :black | :white
  def result_for(board) do
    hexmatrix = board |> HexMatrix.parse()
    cond do
      white_win?(hexmatrix) -> :white
      black_win?(hexmatrix) -> :black
      true -> :none
    end
  end

  defp white_sources(hexmatrix) do
    hexmatrix
    |> HexMatrix.top_positions()
    |> Enum.filter(&(HexMatrix.get(hexmatrix, &1) == @white))
  end

  defp white_destinations(hexmatrix) do
    hexmatrix
    |> HexMatrix.bot_positions()
    |> Enum.filter(&(HexMatrix.get(hexmatrix, &1) == @white))
  end

  defp black_sources(hexmatrix) do
    hexmatrix
    |> HexMatrix.left_positions()
    |> Enum.filter(&(HexMatrix.get(hexmatrix, &1) == @black))
  end

  defp black_destinations(hexmatrix) do
    hexmatrix
    |> HexMatrix.right_positions()
    |> Enum.filter(&(HexMatrix.get(hexmatrix, &1) == @black))
  end

  defp white_win?(hexmatrix) do
    sources = white_sources(hexmatrix)
    destinations = white_destinations(hexmatrix)
    reach?(hexmatrix, sources, destinations)
  end

  defp black_win?(hexmatrix) do
    sources = black_sources(hexmatrix)
    destinations = black_destinations(hexmatrix)
    reach?(hexmatrix, sources, destinations)
  end

  defp reach?(hexmatrix, sources, destinations) do
    sources
    |> Enum.any?(&(search(hexmatrix, &1, MapSet.new([&1]), MapSet.new(destinations))))
  end

  defp search(hexmatrix, current, visited, destinations) do
    cond do
      MapSet.member?(destinations, current) -> true
      true ->
        hexmatrix
        |> HexMatrix.adjacent(current)
        |> Enum.filter(&(not MapSet.member?(visited, &1)))
        |> Enum.filter(&(HexMatrix.get(hexmatrix, &1) == HexMatrix.get(hexmatrix, current)))
        |> Enum.any?(&search(hexmatrix, &1, MapSet.put(visited, &1), destinations))
    end
  end

end
