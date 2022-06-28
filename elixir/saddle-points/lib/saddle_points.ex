defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(""), do: []
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(fn row ->
      row
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(""), do: []
  def columns(str) do
    str
    |> rows()
    |> Stream.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(""), do: []
  def saddle_points(str) do
    rows = rows(str)
    max_rows = rows
    |> Enum.map(&Enum.max/1)
    |> List.to_tuple()
    min_cols = rows
    |> Stream.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.min/1)
    |> List.to_tuple()
    for {row, i} <- Enum.with_index(rows),
        {value, j} <- Enum.with_index(row),
        value >= elem(max_rows, i),
        value <= elem(min_cols, j), do: {i + 1, j + 1}
  end

end
