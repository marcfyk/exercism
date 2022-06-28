defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @books 1..5 |> Enum.to_list()

  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  """
  @spec total(basket :: [book]) :: integer
  def total(basket) do
    books = basket |> count()
    books
    |> generate_iterations()
    |> Enum.reduce(%{}, &Map.put(&2, &1, find_optimal(&1, &2, 0)))
    |> Map.get(books)
  end

  defp count(keys) do
    @books
    |> Enum.reduce(%{}, &Map.put(&2, &1, 0))
    |> Map.merge(keys |> Enum.frequencies())
  end

  defp generate_iterations(books) do
    for ones <- 0..Map.get(books, 1),
        twos <- 0..Map.get(books, 2),
        threes <- 0..Map.get(books, 3),
        fours <- 0..Map.get(books, 4),
        fives <- 0..Map.get(books, 5),
        do: %{1 => ones, 2 => twos, 3 => threes, 4 => fours, 5 => fives}
  end

  defp find_optimal(books, memoize, cost)
  defp find_optimal(%{1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0}, _, cost), do: cost
  defp find_optimal(books, memoize, cost) do
    cond do
      Map.has_key?(memoize, books) -> Map.get(memoize, books) + cost
      true ->
        five = books |> take_n(5) |> Enum.map(&find_optimal(&1, memoize, cost + 3000))
        four = books |> take_n(4) |> Enum.map(&find_optimal(&1, memoize, cost + 2560))
        three = books |> take_n(3) |> Enum.map(&find_optimal(&1, memoize, cost + 2160))
        twos = books |> take_n(2) |> Enum.map(&find_optimal(&1, memoize, cost + 1520))
        ones = books |> take_n(1) |> Enum.map(&find_optimal(&1, memoize, cost + 800))
        [five, four, three, twos, ones]
        |> Enum.flat_map(&(&1))
        |> Enum.min()
    end

  end

  defp powerset([]), do: [[]]
  defp powerset([h | t]) do
    do_not_take = powerset(t)
    take = do_not_take |> Enum.map(&[h | &1])
    [do_not_take, take] |> Enum.flat_map(&(&1))
  end

  defp choose(options, size), do: options |> powerset() |> Enum.filter(&Enum.count(&1) == size)

  defp subtract(books, keys) do
    keys
    |> Enum.reduce(books, &Map.update!(&2, &1, fn x -> x - 1 end))
  end

  defp valid?(books) do
    books
    |> Map.values()
    |> Enum.all?(&(&1 >= 0))
  end

  defp take_n(books, n) do
    @books
    |> choose(n)
    |> Enum.map(&subtract(books, &1))
    |> Enum.filter(&valid?/1)
  end

end
