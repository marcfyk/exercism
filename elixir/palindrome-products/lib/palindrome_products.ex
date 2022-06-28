defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1)
  def generate(max_factor, min_factor) when max_factor < min_factor, do: raise ArgumentError
  def generate(max_factor, min_factor) do
    min_factor..max_factor
    |> Stream.map(fn i -> {i, i..max_factor} end)
    |> Stream.map(fn {i, range} -> Stream.map(range, &{i, &1}) end)
    |> Stream.flat_map(&(&1))
    |> Stream.map(fn {i, j} -> {i, j, i * j} end)
    |> Stream.filter(fn {_, _, product} -> palindrome?(product) end)
    |> Enum.reduce(%{}, fn {x, y, product}, acc ->
      Map.update(acc, product, [[x, y]], fn rest -> [[x, y] | rest] end)
    end)
  end

  defp palindrome?(n) do
    digits = Integer.digits(n)
    Enum.reverse(digits) == digits
  end


end
