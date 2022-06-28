defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value(items, maximum_weight)
  def maximum_value([], _), do: 0
  def maximum_value([%{weight: w, value: _} | _], maximum_weight) when w > maximum_weight, do: 0
  def maximum_value([%{weight: w, value: v} | rest], maximum_weight) do
    do_not_take = maximum_value(rest, maximum_weight)
    take = v + maximum_value(rest, maximum_weight - w)
    max(do_not_take, take)
  end

end
