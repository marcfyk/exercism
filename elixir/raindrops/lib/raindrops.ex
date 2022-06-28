defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    case three(number) <> five(number) <> seven(number) do
      "" -> to_string(number)
      result -> result
    end
  end

  defp transform(condition?, x, y), do: if condition?, do: x, else: y
  defp three(n), do: transform(rem(n, 3) == 0, "Pling", "")
  defp five(n), do: transform(rem(n, 5) == 0, "Plang", "")
  defp seven(n), do: transform(rem(n, 7) == 0, "Plong", "")
end
