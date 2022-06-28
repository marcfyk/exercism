defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun), do: keep_tco(list, fun, [])

  defp keep_tco([], _, acc), do: acc |> Enum.reverse
  defp keep_tco([h | t], fun, acc) do
    case fun.(h) do
      true -> keep_tco(t, fun, [h | acc])
      false -> keep_tco(t, fun, acc)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun), do: keep_tco(list, &(not fun.(&1)), [])
end
