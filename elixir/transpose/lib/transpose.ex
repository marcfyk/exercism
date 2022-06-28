defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @padding "\x00"

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    rows = input
    |> String.split("\n", trim: true)
    max_row_length = rows
    |> Stream.map(&String.length/1)
    |> Enum.max(fn -> 0 end)
    rows
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.pad_trailing(&1, max_row_length, @padding))
    |> Stream.map(&String.graphemes/1)
    |> Stream.zip()
    |> Stream.map(&Tuple.to_list/1)
    |> Stream.map(&Enum.join/1)
    |> Stream.map(&String.trim_trailing(&1, @padding))
    |> Stream.map(&String.replace(&1, @padding, " "))
    |> Enum.join("\n")
  end

end
