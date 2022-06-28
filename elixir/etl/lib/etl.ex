defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Stream.map(fn {point, letters} -> 
      letters
      |> Stream.map(&String.downcase/1)
      |> Stream.map(&{&1, point})
    end)
    |> Stream.flat_map(&(&1))
    |> Enum.into(%{})
  end
end
