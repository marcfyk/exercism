defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes
    |> Stream.chunk_by(&(&1))
    |> Stream.map(&compress/1)
    |> Enum.join("")
  end

  defp compress([]), do: ""
  defp compress([letter]), do: letter
  defp compress([letter | _] = letters), do:
    (letters |> length |> to_string) <> letter 

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.graphemes
    |> build([])
    |> Enum.join("")
  end

  defp build([], acc), do: acc |> Enum.reverse
  defp build(tokens, acc) do
    {prefix, [letter | suffix]} = tokens |> Enum.split_while(&("0" <= &1 and &1 <= "9"))
    count = case prefix |> Enum.join("") do
      "" -> 1
      n -> n |> Integer.parse |> elem(0)
    end
    build(suffix, [String.duplicate(letter, count) | acc])
  end

end
