defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digit_list = number |> digits
    digit_list
    |> Enum.map(fn x -> x ** length(digit_list) end)
    |> Enum.sum
    == number
  end

  defp digits(number), do: digits_acc(number, [])

  defp digits_acc(0, []), do: [0]
  defp digits_acc(0, list), do: list
  defp digits_acc(number, list),
    do: digits_acc(div(number, 10), [rem(number, 10) | list])
end
