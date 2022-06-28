defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    {a, b, c}
    |> check_positive
    |> check_inequality
    |> check_type
  end

  defp check_positive({a, b, c}) do
    cond do
      a <= 0 or b <= 0 or c <= 0 -> {:error, "all side lengths must be positive"}
      true -> {:ok, a, b, c}
    end
  end

  defp check_inequality({:error, message}), do: {:error, message}
  defp check_inequality({:ok, a, b, c}) do
    cond do
      a + b < c -> {:error, "side lengths violate triangle inequality"}
      b + c < a -> {:error, "side lengths violate triangle inequality"}
      a + c < b -> {:error, "side lengths violate triangle inequality"}
      true -> {:ok, a, b, c}
    end
  end

  defp check_type({:error, message}), do: {:error, message}
  defp check_type({:ok, a, b, c}) do
    cond do
      a == b and b == c -> {:ok, :equilateral}
      a == b -> {:ok, :isosceles}
      b == c -> {:ok, :isosceles}
      a == c -> {:ok, :isosceles}
      true -> {:ok, :scalene}
    end
  end

end
