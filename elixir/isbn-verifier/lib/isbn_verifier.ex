defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn
    |> isbn_digits
    |> checksum
    |> valid_checksum?
  end

  defp parse_isbn_digit("X"), do: {:ok, 10}
  defp parse_isbn_digit(d) do
    case Integer.parse(d) do
      :error -> :error
      {n, _} -> {:ok, n}
    end
  end

  defp isbn_digits(isbn) do
    parsed = isbn
    |> String.upcase
    |> String.replace("-", "")
    |> String.graphemes
    |> Stream.map(&parse_isbn_digit/1)
    cond do
      Enum.any?(parsed, &(&1 == :error)) -> :error
      Enum.count(parsed) != 10 -> :error
      true ->
        digits = parsed |> Enum.map(fn {_, n} -> n end)
        {:ok, digits}
    end
  end

  defp checksum(:error), do: :error
  defp checksum({:ok, digits}) do
    {
      :ok,
      digits
      |> Stream.zip(10..1)
      |> Stream.map(fn {d, w} -> d * w end)
      |> Enum.sum
    }
  end

  defp valid_checksum?(:error), do: false
  defp valid_checksum?({:ok, checksum}), do: rem(checksum, 11) == 0

end
