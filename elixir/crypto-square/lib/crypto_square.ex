defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    plaintext = get_plaintext(str)
    dimensions = get_dimensions(plaintext)
    {plaintext, dimensions}
    |> get_plaintext_table()
    |> transpose()
    |> Stream.map(&Enum.join(&1, ""))
    |> Enum.join(" ")
  end

  defp get_plaintext(str) do
    str
    |> String.downcase()
    |> String.graphemes()
    |> Enum.filter(&Regex.match?(~r/[\w\d]/, &1))
  end

  defp get_dimensions(plaintext) do
    sqrt = plaintext
    |> length()
    |> Kernel.**(0.5)
    r = floor(sqrt)
    c = ceil(sqrt)
    {r, c}
  end

  defp pad_row(row, n) do
    diff = n - length(row)
    cond do
      diff > 0 -> row ++ List.duplicate(" ", diff)
      true -> row
    end
  end

  defp get_plaintext_table({plaintext, {_, c}}) when c <= 0, do: [[plaintext]]
  defp get_plaintext_table({plaintext, {_, c}}) do
    plaintext
    |> Stream.chunk_every(c)
    |> Stream.map(&pad_row(&1, c))
  end

  defp transpose(table) do
    table
    |> Stream.zip()
    |> Stream.map(&Tuple.to_list/1)
  end

end
