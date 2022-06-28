defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase
    |> to_charlist
    |> Stream.map(&letter_score/1)
    |> Enum.sum
  end

  defp letter_score(?A), do: 1
  defp letter_score(?E), do: 1
  defp letter_score(?I), do: 1
  defp letter_score(?O), do: 1
  defp letter_score(?U), do: 1
  defp letter_score(?L), do: 1
  defp letter_score(?N), do: 1
  defp letter_score(?R), do: 1
  defp letter_score(?S), do: 1
  defp letter_score(?T), do: 1
  
  defp letter_score(?D), do: 2
  defp letter_score(?G), do: 2

  defp letter_score(?B), do: 3
  defp letter_score(?C), do: 3
  defp letter_score(?M), do: 3
  defp letter_score(?P), do: 3

  defp letter_score(?F), do: 4
  defp letter_score(?H), do: 4
  defp letter_score(?V), do: 4
  defp letter_score(?W), do: 4
  defp letter_score(?Y), do: 4

  defp letter_score(?K), do: 5

  defp letter_score(?J), do: 8
  defp letter_score(?X), do: 8

  defp letter_score(?Q), do: 10
  defp letter_score(?Z), do: 10

  defp letter_score(_), do: 0
end
