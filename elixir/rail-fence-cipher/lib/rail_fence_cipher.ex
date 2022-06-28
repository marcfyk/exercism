defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(str, 1), do: str
  def encode("", _), do: ""
  def encode(str, rails) do
    str
    |> String.graphemes()
    |> Stream.zip(Stream.concat(0..rails - 1, rails - 2..1) |> Stream.cycle())
    |> Stream.map(fn {value, index} -> {rem(index, rails), value} end)
    |> Enum.reduce(%{}, fn {modulo, value}, acc ->
      Map.update(acc, modulo, [value], fn values -> [value | values] end)
    end)
    |> Map.values()
    |> Stream.map(&Enum.reverse/1)
    |> Stream.flat_map(&(&1))
    |> Enum.join()
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, 1), do: str
  def decode("", _), do: ""
  def decode(str, rails) do
    0..rails - 1
    |> Stream.concat(rails - 2..1)
    |> Stream.cycle()
    |> Stream.zip(0..String.length(str) - 1)
    |> Enum.sort_by(&elem(&1, 0))
    |> Stream.zip(String.graphemes(str))
    |> Enum.sort_by(fn {{_, x}, _} -> x end)
    |> Stream.map(&elem(&1, 1))
    |> Enum.join()
  end
end
