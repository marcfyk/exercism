defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) when number < 2, do: []
  def factors_for(number), do: prime_factors(2, number, [])

  defp prime?(n) when n < 2, do: false
  defp prime?(n) when n == 2, do: true
  defp prime?(n) do
    2..n - 1
    |> Enum.all?(&(not factor?(n, &1)))
  end

  defp factor?(dividend, divisor), do: rem(dividend, divisor) == 0

  defp prime_factors(factor, number, acc) do
    cond do
      number == 1 -> acc |> Enum.reverse()
      factor > number -> acc |> Enum.reverse()
      not factor?(number, factor) -> prime_factors(factor + 1, number, acc)
      not prime?(factor) -> prime_factors(factor + 1, number, acc)
      true -> prime_factors(factor, div(number, factor), [factor | acc])
    end
  end

end
