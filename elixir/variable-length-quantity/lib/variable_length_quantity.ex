defmodule VariableLengthQuantity do
  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode(integers) do
    integers
    |> Stream.map(&encode_number(&1, 0, <<>>))
    |> Enum.reverse()
    |> Enum.reduce(<<>>, &<>/2)
  end

  defp encode_number(0, _, <<>>), do: <<0>>
  defp encode_number(0, _, acc), do: acc
  defp encode_number(n, b, acc) do
    n
    |> Bitwise.>>>(7)
    |> encode_number(1, <<b::1, n::7, acc::binary>>)
  end

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes), do: bytes |> decode_sequence(0, [])

  defp decode_sequence(<<>>, 0, []), do: {:error, "incomplete sequence"}
  defp decode_sequence(<<>>, 0, acc), do: {:ok, acc |> Enum.reverse()}
  defp decode_sequence(<<x::1, y::7, tail::binary>>, n, acc) do
    result = n
    |> Bitwise.<<<(7)
    |> Bitwise.|||(y)
    case x do
      0 -> decode_sequence(tail, 0, [result | acc])
      1 -> decode_sequence(tail, result, acc)
    end
  end
  defp decode_sequence(_, _, _), do: {:error, "incomplete sequence"}
end
