defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    line_one(number) <> "\n" <> line_two(number) <> "\n"
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    range
    |> Stream.map(&verse/1)
    |> Enum.join("\n")
  end

  defp beers(0), do: beers("no more")
  defp beers(1), do: "1 bottle of beer"
  defp beers(n), do: "#{n} bottles of beer"

  defp line_one(0),
    do: line_one("no more")
  defp line_one(n),
    do: "#{n |> beers |> String.capitalize} on the wall, #{beers(n)}."

  defp line_two(0),
    do: "Go to the store and buy some more, #{beers(99)} on the wall."
  defp line_two(1),
    do: "Take it down and pass it around, #{beers(0)} on the wall."
  defp line_two(n),
    do: "Take one down and pass it around, #{beers(n - 1)} on the wall."
end
