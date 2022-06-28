defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase
    |> to_charlist
    |> Stream.filter(&valid_character?/1)
    |> Stream.chunk_every(5)
    |> Stream.map(&transform_block/1)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.split(" ")
    |> Stream.map(&to_charlist/1)
    |> Stream.map(&transform_block/1)
    |> Enum.join()
  end

  defp valid_character?(c), do: (?a <= c and c <= ?z) or (?0 <= c and c <= ?9)

  defp letter(c) when ?a <= c and c <= ?z, do: letter(c, ?a)
  defp letter(c), do: c
  defp letter(c, offset) do
    offset + 25 - c + offset
  end

  defp transform_block(block), do: block |> Enum.map(&letter/1)

end
