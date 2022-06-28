defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l), do: count_tc(l, 0)
  defp count_tc([], count), do: count
  defp count_tc([_ | t], count), do: count_tc(t, count + 1)

  @spec reverse(list) :: list
  def reverse(l), do: reverse_tc(l, [])
  defp reverse_tc([], acc), do: acc
  defp reverse_tc([h | t], acc), do: reverse_tc(t, [h | acc])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: map_tc(l, f, [])
  defp map_tc([], _, acc), do: reverse(acc)
  defp map_tc([h | t], f, acc), do: map_tc(t, f, [f.(h) | acc])


  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: filter_tc(l, f, [])
  defp filter_tc([], _, acc), do: reverse(acc)
  defp filter_tc([h | t], f, acc) do
    if f.(h),
    do: filter_tc(t, f, [h | acc]),
    else: filter_tc(t, f, acc)
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl(l, acc, f)
  def foldl([], acc, _), do: acc
  def foldl([h | t], acc, f), do: foldl(t, f.(h, acc), f)


  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f), do: l |> reverse() |> foldl(acc, f)

  @spec append(list, list) :: list
  def append(a, []), do: a
  def append(a, b), do: a |> reverse() |> append_tc(b)
  defp append_tc([], b), do: b
  defp append_tc([h | t], b), do: append_tc(t, [h | b])

  @spec concat([[any]]) :: [any]
  def concat(ll), do: foldr(ll, [], &append/2)
end
