defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ", trim: true)
    |> Stream.map(&String.graphemes/1)
    |> Stream.map(&transform/1)
    |> Enum.join(" ")
  end


  @vowels ["a", "e", "i", "o", "u"]
  defp transform(["q", "u" | t]), do: t ++ ["quay"]
  defp transform(["x", c | _] = graphemes) when c not in @vowels, do: graphemes ++ ["ay"]
  defp transform(["y", c | _] = graphemes) when c not in @vowels, do: graphemes ++ ["ay"]
  defp transform([v | _] = graphemes) when v in @vowels, do: graphemes ++ ["ay"]
  defp transform([h | t]), do: transform(t ++ [h])


end
