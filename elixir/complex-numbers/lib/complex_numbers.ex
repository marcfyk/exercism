defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {float, float}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: float
  def real(a) do
    elem(a, 0)
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: float
  def imaginary(a) do
    elem(a, 1)
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | float, b :: complex | float) :: complex
  def mul(a, b) when is_number(a), do: mul({a, 0}, b)
  def mul(a, b) when is_number(b), do: mul(a, {b, 0})
  def mul(a, b) do
    r = real(a) * real(b) - imaginary(a) * imaginary(b)
    i = imaginary(a) * real(b) + real(a) * imaginary(b)
    {r, i}
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | float, b :: complex | float) :: complex
  def add(a, b) when is_number(a), do: add({a, 0}, b)
  def add(a, b) when is_number(b), do: add(a, {b, 0})
  def add(a, b) do
    r = real(a) + real(b)
    i = imaginary(a) + imaginary(b)
    {r, i}
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | float, b :: complex | float) :: complex
  def sub(a, b) when is_number(a), do: sub({a, 0}, b)
  def sub(a, b) when is_number(b), do: sub(a, {b, 0})
  def sub(a, b) do
    r = real(a) - real(b)
    i = imaginary(a) - imaginary(b)
    {r, i}
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | float, b :: complex | float) :: complex
  def div(a, b) when is_number(a), do: __MODULE__.div({a, 0}, b)
  def div(a, b) when is_number(b), do: __MODULE__.div(a, {b, 0})
  def div(a, b) do
    r = (real(a) * real(b) + imaginary(a) * imaginary(b)) / (real(b) ** 2 + imaginary(b) ** 2)
    i = (imaginary(a) * real(b) - real(a) * imaginary(b)) / (real(b) ** 2 + imaginary(b) ** 2)
    {r, i}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: float
  def abs(a) do
    (real(a) ** 2 + imaginary(a) ** 2) ** 0.5
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate(a) do
    {real(a), -imaginary(a)}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp(a) do
    r = :math.exp(real(a))
    i = {:math.cos(imaginary(a)), :math.sin(imaginary(a))}
    mul(r, i)
  end
end
