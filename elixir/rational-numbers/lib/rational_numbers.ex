defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(x :: rational, y :: rational) :: rational
  def add({xa, xb}, {ya, yb}) do
    {xa * yb + xb * ya, xb * yb} |> reduce
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(x :: rational, y :: rational) :: rational
  def subtract({xa, xb}, {ya, yb}) do
    {xa * yb - xb * ya, xb * yb} |> reduce
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(x :: rational, y :: rational) :: rational
  def multiply({xa, xb}, {ya, yb}) do
    {xa * ya, xb * yb} |> reduce
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({num_a, num_b}, {den_a, den_b}) do
    {num_a * den_b, num_b * den_a} |> reduce
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(x :: rational) :: rational
  def abs({a, b}) do
    {Kernel.abs(a), Kernel.abs(b)} |> reduce
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(x :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when n < 0 do 
    pow_rational({b, a}, Kernel.abs(n))
  end
  def pow_rational({a, b}, n) do
    {a ** n, b ** n} |> reduce
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n) do
    {a, b} = n
    x ** (a / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(x :: rational) :: rational
  def reduce({a, b}) when b < 0 do
    reduce({-a, -b})
  end
  def reduce({a, b}) do
      gcd = Integer.gcd(a, b)
      {div(a, gcd), div(b, gcd)}
  end
end
