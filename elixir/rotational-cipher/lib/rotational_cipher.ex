defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&(mapping(&1, shift)))
    |> to_string
  end

  defp mapping(c, shift) when ?a <= c and c <= ?z, do: rem((c - ?a) + shift, 26) + ?a
  defp mapping(c, shift) when ?A <= c and c <= ?Z, do: rem((c - ?A) + shift, 26) + ?A
  defp mapping(c, _), do: c
end
