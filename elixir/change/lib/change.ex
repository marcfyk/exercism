defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    0..target
    |> Enum.reduce(%{}, &memoize(coins, &1, &2))
    |> Map.fetch(target)
    |> fn
      {:ok, _} = result -> result
      _ -> {:error, "cannot change"}
    end.()
  end

  defp memoize(coins, target, map) do
    case find_optimal(coins, target, map, []) do
      {:ok, result} -> Map.put(map, target, result)
      :error -> map
    end
  end

  defp find_optimal(_, 0, _, acc), do: {:ok, acc}
  defp find_optimal(_, target, _, _) when target < 0, do: :error
  defp find_optimal([], _, _, _), do: :error
  defp find_optimal(coins, target, map, acc) do
    coins
    |> Stream.map(fn coin ->
      case Map.fetch(map, target - coin) do
        :error -> find_optimal(coins, target - coin, map, [coin | acc])
        {:ok, result} -> {:ok, [coin | result]}
      end
    end)
    |> Stream.filter(&(&1 != :error))
    |> Enum.min_by(&(&1 |> elem(1) |> Enum.count()), fn -> :error end)
  end


end
