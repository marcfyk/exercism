defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(fn c -> anagram?(c, base) end)
  end

  defp letter_map(word) do
    word
    |> to_charlist
    |> Enum.reduce(%{}, fn c, acc -> Map.update(acc, c, 1, fn x -> x + 1 end) end) 
  end

  defp anagram?(x, y) do
    x_upcase = x |> String.upcase
    y_upcase = y |> String.upcase
    x_upcase != y_upcase and letter_map(x_upcase) == letter_map(y_upcase)
  end
end
