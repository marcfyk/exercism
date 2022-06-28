defmodule Alphametics do
  @type puzzle :: binary
  @type solution :: %{required(?A..?Z) => 0..9}

  @doc """
  Takes an alphametics puzzle and returns a solution where every letter
  replaced by its number will make a valid equation. Returns `nil` when
  there is no valid solution to the given puzzle.

  ## Examples

    iex> Alphametics.solve("I + BB == ILL")
    %{?I => 1, ?B => 9, ?L => 0}

    iex> Alphametics.solve("A == B")
    nil
  """
  @nonzero_digits 1..9 |> Enum.to_list()
  @digits 0..9 |> Enum.to_list()

  @spec solve(puzzle) :: solution | nil
  def solve(puzzle) do
    {[starting_result | _] = result, terms} = puzzle
    |> String.split(~r/ \+ | \=\= /)
    |> Enum.map(&to_charlist/1)
    |> List.pop_at(-1)
    starting_letters = get_starting_letters(terms, starting_result)
    letters = get_all_letters(puzzle, starting_letters)
    starting_letters
    |> get_permutations(letters, [])
    |> Enum.find(&valid?(terms, result, &1))
  end

  defp get_starting_letters(terms, starting_result) do
    terms
    |> Enum.map(&hd/1)
    |> fn terms -> [starting_result | terms] end.()
    |> Enum.uniq()
  end

  defp get_all_letters(puzzle, starting_letters) do
    puzzle
    |> to_charlist()
    |> Enum.uniq()
    |> Kernel.--([?+, ?=, ?\s | starting_letters])
  end

  defp get_permutations(starting_letters, letters, used)
  defp get_permutations([], [], _), do: [Map.new()]
  defp get_permutations([], [first_letter | letters], used) do
    for value <- @digits |> Kernel.--(used),
        perm <- get_permutations([], letters, [value | used]), do: Map.put(perm, first_letter, value)
  end
  defp get_permutations([first_starting_letter | starting_letters], letters, used) do
    for value <- @nonzero_digits |> Kernel.--(used),
        perm <- get_permutations(starting_letters, letters, [value | used]), do: Map.put(perm, first_starting_letter, value)
  end

  defp valid?(terms, result, values) do
    terms
    |> Enum.map(&get_number(&1, values))
    |> Enum.sum()
    |> Kernel.==(get_number(result, values))
  end

  defp get_number(letters, values) do
    letters
    |> Enum.reduce(0, fn letter, value ->
      value
      |> Kernel.*(10)
      |> Kernel.+(Map.get(values, letter))
    end)
  end
end
