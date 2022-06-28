defmodule Secrets do
  def secret_add(secret) do
    fn to_add -> to_add + secret end
  end

  def secret_subtract(secret) do
    fn value -> value - secret end
  end

  def secret_multiply(secret) do
    fn weight -> secret * weight end
  end

  def secret_divide(secret) do
    fn value -> div(value, secret) end
  end

  def secret_and(secret) do
    fn value -> Bitwise.&&&(value, secret) end
  end

  def secret_xor(secret) do
    fn value -> Bitwise.^^^(value, secret) end
  end

  def secret_combine(secret_function1, secret_function2) do
    fn value -> List.foldl(
      [secret_function1, secret_function2], value,
      fn x, acc -> x.(acc) end)
    end
  end
end
