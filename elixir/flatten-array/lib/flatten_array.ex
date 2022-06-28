defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    flat(list)
    |> Enum.filter(&(not is_nil(&1)))
  end


  defp flat([]), do: []
  defp flat([h | t]) when is_list(h), do: flat(h) ++ flat(t)
  defp flat([h | t]), do: [h | flat(t)]
end
