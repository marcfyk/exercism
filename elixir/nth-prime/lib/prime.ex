defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.filter(&prime?/1)
    |> Stream.take(count)
    |> Stream.drop(count - 1)
    |> Enum.to_list
    |> List.first
  end

  defp prime?(2), do: true
  defp prime?(n) when is_integer(n) do
    2..div(n, 2) + 1
    |> Enum.all?(&(rem(n, &1) != 0))
  end
end
