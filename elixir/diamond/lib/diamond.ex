defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(?A), do: "A\n"
  def build_shape(letter) do
    dimension = 2 * (letter - ?A) + 1
    Stream.concat(?A..letter, letter - 1..?A)
    |> Stream.map(&line(&1, dimension))
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end

  defp line(letter, length) do
    mid = div(length, 2)
    offset = letter - ?A
    target_index_one = mid - offset
    target_index_two = mid + offset
    0..length - 1
    |> Enum.map(fn i ->
      case i do
        ^target_index_one -> letter
        ^target_index_two -> letter
        _ -> ' '
      end
    end)
    |> to_string()
  end


end
