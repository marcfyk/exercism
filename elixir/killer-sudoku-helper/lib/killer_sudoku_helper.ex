defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(cage) do
    excluded_numbers = Enum.into(cage.exclude, MapSet.new)
    number_range = Stream.filter(1..9, &(not MapSet.member?(excluded_numbers, &1)))
    get_combinations(cage.size, number_range)
    |> Enum.into(MapSet.new())
    |> Stream.filter(&(Enum.sum(&1) == cage.sum))
    |> Stream.map(&Enum.to_list/1)
    |> Enum.sort()
  end

  defp get_combinations(1, range) do
    range
    |> Enum.map(&MapSet.new([&1]))
  end
  defp get_combinations(size, range) when size > 1 do
    for x <- get_combinations(size - 1, range),
        y <- range,
        not MapSet.member?(x, y) do
          MapSet.put(x, y)
        end
  end

end
