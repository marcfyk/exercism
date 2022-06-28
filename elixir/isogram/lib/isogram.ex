defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> letter_count()
    |> valid?()
  end

  defp letter_count(sentence) do
    sentence
    |> String.downcase()
    |> String.graphemes()
    |> Stream.filter(&("a" <= &1 and &1 <= "z"))
    |> Enum.reduce(Map.new(), fn c, acc -> Map.update(acc, c, 1, &(&1 + 1)) end)
  end

  defp valid?(counts) do
    counts
    |> Map.values()
    |> Enum.all?(&(&1 == 1))
  end

end
