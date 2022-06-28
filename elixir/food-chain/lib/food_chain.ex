defmodule FoodChain do

  @lines {
    {"fly", nil},
    {"spider", "It wriggled and jiggled and tickled inside her."},
    {"bird", "How absurd to swallow a bird!"},
    {"cat", "Imagine that, to swallow a cat!"},
    {"dog", "What a hog, to swallow a dog!"},
    {"goat", "Just opened her throat and swallowed a goat!"},
    {"cow", "I don't know how she swallowed a cow!"},
    {"horse", nil},
  }

  defp name(index), do: @lines |> elem(index - 1) |> elem(0)

  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    start..stop
    |> Stream.map(&verse/1)
    |> Stream.intersperse("")
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end

  defp opening_verse(index), do: "I know an old lady who swallowed a #{name(index)}."

  defp second_verse(index), do: @lines |> elem(index - 1) |> elem(1)

  defp ending_verse(8), do: "She's dead, of course!"
  defp ending_verse(_), do: "I don't know why she swallowed the fly. Perhaps she'll die."

  defp verse(8), do: opening_verse(8) <> "\n" <> ending_verse(8)
  defp verse(1), do: opening_verse(1) <> "\n" <> ending_verse(1)
  defp verse(index) do
    body = index..2
    |> Stream.map(&line/1)
    |> Enum.join("\n")
    [opening_verse(index), second_verse(index), body, ending_verse(1)]
    |> Enum.join("\n")
  end

  defp line(3), do: "She swallowed the #{name(3)} to catch the #{name(2)} that wriggled and jiggled and tickled inside her."
  defp line(index), do: "She swallowed the #{name(index)} to catch the #{name(index - 1)}."

end
