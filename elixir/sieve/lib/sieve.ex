defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) when limit < 2, do: []
  def primes_to(limit) do
    generate_primes(2, limit, MapSet.new())
  end

  defp generate_primes(n, limit, _) when n > limit, do: []
  defp generate_primes(n, limit, non_primes) do
    cond do
      MapSet.member?(non_primes, n) -> generate_primes(n + 1, limit, non_primes)
      true ->
        Stream.iterate(2, &(&1 + 1))
        |> Stream.map(&(&1 * n))
        |> Stream.take_while(&(&1 <= limit))
        |> Enum.reduce(non_primes, &MapSet.put(&2, &1))
        |> fn mapset -> [n | generate_primes(n + 1, limit, mapset)] end.()
    end
  end
end
