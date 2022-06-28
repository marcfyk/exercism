defmodule AffineCipher do

  defp letter_index(letter) do
    letter
    |> to_charlist()
    |> hd()
    |> Kernel.-(?a)
  end

  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}
  @m 26

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, message) do
    case Integer.extended_gcd(a, @m) do
      {1, _, _} ->
        {
          :ok,
          message
          |> String.downcase()
          |> String.graphemes()
          |> Stream.filter(&String.match?(&1, ~r/[[:alnum:]]/))
          |> Enum.map(&encode_letter(&1, a, b))
          |> Enum.chunk_every(5)
          |> Enum.intersperse([" "])
          |> Enum.flat_map(&(&1))
          |> to_string()
        }
      _ -> {:error, "a and m must be coprime."}
    end
  end

  defp encode_letter(letter, a, b) do
    cond do
      String.match?(letter, ~r/[[:alpha:]]/) ->
        rem(letter_index(letter) * a + b, @m) + ?a
      String.match?(letter, ~r/[[:digit:]]/) -> letter
    end
  end

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, encrypted) do
    case Integer.extended_gcd(a, @m) do
      {1, _, _} ->
        {
          :ok,
          encrypted
          |> String.graphemes()
          |> Enum.filter(&(&1 != " "))
          |> Enum.map(&decode_letter(&1, a, b))
          |> to_string()
        }
      _ -> {:error, "a and m must be coprime."}
    end
  end

  defp decode_letter(letter, a, b) do
    cond do
      String.match?(letter, ~r/[[:digit:]]/) -> letter
      String.match?(letter, ~r/[[:lower:]]/) ->
        rem(rem(mmi(a, @m) * (letter_index(letter) - b), @m) + @m, @m) + ?a
    end
  end

  defp mmi(a, m) do
    {_, x, _} = Integer.extended_gcd(a, m)
    rem(x, m)
  end

end
