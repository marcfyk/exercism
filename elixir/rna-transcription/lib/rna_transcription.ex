defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna), do: dna |> Enum.map(&transform/1)

  defp transform(?G), do: ?C
  defp transform(?C), do: ?G
  defp transform(?T), do: ?A
  defp transform(?A), do: ?U
end
