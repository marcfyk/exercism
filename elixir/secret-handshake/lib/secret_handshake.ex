defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code
    |> Integer.digits(2)
    |> Enum.reverse
    |> build(0, [])
  end


  defp build([], _, acc), do: acc |> Enum.reverse

  defp build([h | t], 0, acc) when h == 1, do: build(t, 1, ["wink" | acc])
  defp build([h | t], 0, acc) when h == 0, do: build(t, 1, acc)

  defp build([h | t], 1, acc) when h == 1, do: build(t, 2, ["double blink" | acc])
  defp build([h | t], 1, acc) when h == 0, do: build(t, 2, acc)

  defp build([h | t], 2, acc) when h == 1, do: build(t, 3, ["close your eyes" | acc])
  defp build([h | t], 2, acc) when h == 0, do: build(t, 3, acc)

  defp build([h | t], 3, acc) when h == 1, do: build(t, 4, ["jump" | acc])
  defp build([h | t], 3, acc) when h == 0, do: build(t, 4, acc)

  defp build([h | _], 4, acc) when h == 1, do: acc
  defp build([h | _], 4, acc) when h == 0, do: acc |> Enum.reverse

end
