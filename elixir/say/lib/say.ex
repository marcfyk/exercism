defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < 0 or number > 999_999_999_999, do: {:error, "number is out of range"}
  def in_english(number), do: {:ok, spell_number(number)}

  defp spell_number(number) do
    number
    |> Integer.digits()
    |> Enum.reverse()
    |> Stream.chunk_every(3)
    |> Stream.zip([:one, :thousand, :million, :billion, :trillion])
    |> Stream.map(fn {digits, unit} -> {Enum.reverse(digits), unit} end)
    |> Stream.map(fn {digits, unit} -> {spell(digits), unit} end)
    |> Stream.map(fn {spelled, unit} -> format(spelled, unit) end)
    |> Stream.map(&String.trim/1)
    |> Stream.filter(&(&1 != ""))
    |> Enum.reverse()
    |> Enum.join(" ")
  end

  defp spell([0]), do: "zero"
  defp spell([1]), do: "one"
  defp spell([2]), do: "two"
  defp spell([3]), do: "three"
  defp spell([4]), do: "four"
  defp spell([5]), do: "five"
  defp spell([6]), do: "six"
  defp spell([7]), do: "seven"
  defp spell([8]), do: "eight"
  defp spell([9]), do: "nine"

  defp spell([0, 0]), do: ""
  defp spell([1, 0]), do: "ten"
  defp spell([2, 0]), do: "twenty"
  defp spell([3, 0]), do: "thirty"
  defp spell([4, 0]), do: "forty"
  defp spell([5, 0]), do: "fifty"
  defp spell([8, 0]), do: "eighty"
  defp spell([n, 0]), do: "#{spell([n])}ty"

  defp spell([1, 1]), do: "eleven"
  defp spell([1, 2]), do: "twelve"
  defp spell([1, 3]), do: "thirteen"
  defp spell([1, 5]), do: "fifteen"
  defp spell([1, n]), do: "#{spell([n])}teen"
  defp spell([m, n]), do: "#{spell([m, 0])}-#{spell([n])}"

  defp spell([0, 0, 0]), do: ""
  defp spell([0, 0, n]), do: spell([n])
  defp spell([0, m, n]), do: spell([m, n])
  defp spell([l, m, n]), do: "#{spell([l])} #{:hundred} #{spell([m, n])}"

  defp format(spelled_digits, :one), do: spelled_digits
  defp format("", _), do: ""
  defp format(spelled_digits, unit), do: "#{spelled_digits} #{unit}"

end
