defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key), do: search(numbers, key, 0, tuple_size(numbers) - 1)

  defp search(_, _, left, right) when left > right, do: :not_found

  defp search(numbers, key, left, right) when elem(numbers, div(left + right, 2)) < key,
    do: search(numbers, key, div(left + right, 2) + 1, right)
  defp search(numbers, key, left, right) when elem(numbers, div(left + right, 2)) > key,
    do: search(numbers, key, left, div(left + right, 2) - 1)
  defp search(_, _, left, right), do: {:ok, div(left + right, 2)}
end
