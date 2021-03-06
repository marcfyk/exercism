defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
    plaintext
    |> to_charlist()
    |> Enum.zip(to_charlist(key) |> Stream.cycle() |> Stream.take(String.length(plaintext)))
    |> Enum.map(fn {letter, shift_letter} -> encode_letter(letter, shift_letter - ?a) end)
    |> to_string()
  end

  defp encode_letter(letter, shift) do
    letter
    |> Kernel.-(?a)
    |> Kernel.+(shift)
    |> Kernel.rem(26)
    |> Kernel.+(?a)
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    ciphertext
    |> to_charlist()
    |> Stream.zip(to_charlist(key) |> Stream.cycle() |> Stream.take(String.length(ciphertext)))
    |> Enum.map(fn {letter, letter_shift} -> decode_letter(letter, letter_shift - ?a) end)
    |> to_string()
  end

  defp decode_letter(letter, shift), do: encode_letter(letter, 26 - shift)

  @doc """
  Generate a random key of a given length. It should contain lowercase letters only.
  """
  def generate_key(length) do
    generate_letter = fn -> :rand.uniform(26) - 1 + ?a end
    Stream.repeatedly(generate_letter)
    |> Stream.take(length)
    |> Enum.to_list()
    |> to_string()
  end

end
