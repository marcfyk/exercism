defmodule Matrix do
  defstruct [:grid, :row, :col]

  def parse(input) do
    grid = input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&List.to_tuple/1)
    |> List.to_tuple()
    row = grid |> tuple_size()
    col = if row == 0, do: 0, else: grid |> elem(0) |> tuple_size()
    %Matrix{grid: grid, row: row, col: col}
  end

  def adjacent(matrix, {i, j}, distance \\ 1) do
    for x <- i-distance..i+distance//distance,
        y <- j-distance..j+distance//distance,
        0 <= x and x < matrix.row,
        0 <= y and y < matrix.col,
        x != i or y != j,
        do: {x, y}
  end

  def get_path({start_x, start_y}, {stop_x, stop_y}) do
    case {{start_x, start_y}, {stop_x, stop_y}} do
      {{start_x, _}, {^start_x, _}} -> start_y..stop_y |> Enum.map(&{start_x, &1})
      {{_, start_y}, {_, ^start_y}} -> start_x..stop_x |> Enum.map(&{&1, start_y})
      _ -> Enum.zip(start_x..stop_x, start_y..stop_y)
    end
  end

  def sequence(matrix, path) do
    path
    |> Enum.map(&Matrix.get(matrix, &1))
    |> Enum.join()
  end

  def get(matrix, {i, j}), do: matrix.grid |> elem(i) |> elem(j)

end

defmodule WordSearch do
  defmodule Location do
    defstruct [:from, :to]

    @type t :: %Location{
            from: %{row: integer, column: integer},
            to: %{row: integer, column: integer}
          }
  end

  @doc """
  Find the start and end positions of words in a grid of letters.
  Row and column positions are 1 indexed.
  """
  @spec search(grid :: String.t(), words :: [String.t()]) :: %{String.t() => nil | Location.t()}
  def search(grid, words) do
    grid
    |> Matrix.parse()
    |> find_index_pairs(words)
    |> format_map()
  end

  defp find_index_pairs(matrix, words) do
    for i <- 0..matrix.row-1,
        j <- 0..matrix.col-1 do
          words
          |> Enum.map(fn word ->
            result = find_end(matrix, {i, j}, word)
            case result do
              :none -> :none
              stop -> {word, {{i, j}, stop}}
            end
          end)
          |> Enum.filter(&(&1 != :none))
    end
    |> Enum.filter(&(&1 != :none))
    |> Enum.flat_map(&(&1))
    |> Enum.into(%{})
    |> fn mappings ->
      words
      |> Enum.filter(&(not Map.has_key?(mappings, &1)))
      |> Enum.reduce(mappings, &Map.put(&2, &1, nil))
    end.()
  end

  defp format_map(mappings) do
    mappings
    |> Enum.map(fn {key, value} ->
      formatted_value = case value do
        nil -> nil
        {{start_x, start_y}, {stop_x, stop_y}} ->
          %Location{
            from: %{row: start_x + 1, column: start_y + 1},
            to: %{row: stop_x + 1, column: stop_y + 1}
          }
      end
      {key, formatted_value}
    end)
    |> Enum.into(%{})
  end

  defp find_end(matrix, {i, j}, word) do
    stops = matrix
    |> Matrix.adjacent({i, j}, String.length(word) - 1)
    |> Enum.filter(fn stop ->
      path = Matrix.get_path({i, j}, stop)
      result = Matrix.sequence(matrix, path)
      result == word
    end)
    case stops do
      [] -> :none
      stops -> stops |> hd()
    end
  end

end
