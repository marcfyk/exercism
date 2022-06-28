defmodule Number do
  @enforce_keys [:roman_repr, :value]
  defstruct [:roman_repr, :value]
end

defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    number
    |> parse([])
    |> Enum.into("")
  end

  @one %Number{roman_repr: "I", value: 1}
  @four %Number{roman_repr: "IV", value: 4}
  @five %Number{roman_repr: "V", value: 5}
  @nine %Number{roman_repr: "IX", value: 9}
  @ten %Number{roman_repr: "X", value: 10}
  @forty %Number {roman_repr: "XL", value: 40}
  @fifty %Number{roman_repr: "L", value: 50}
  @ninety %Number{roman_repr: "XC", value: 90}
  @hundred %Number{roman_repr: "C", value: 100}
  @four_hundred %Number{roman_repr: "CD", value: 400}
  @five_hundred %Number{roman_repr: "D", value: 500}
  @nine_hundred %Number{roman_repr: "CM", value: 900}
  @thousand %Number{roman_repr: "M", value: 1000}

  @numerals [@thousand, @nine_hundred, @five_hundred, @four_hundred, @hundred,
    @ninety, @fifty, @forty, @ten, @nine, @five, @four, @one]

  defp parse(0, acc), do: acc |> Enum.reverse
  defp parse(n, acc) do
    value = @numerals
    |> Stream.filter(&(n >= &1.value))
    |> Stream.take(1)
    |> Enum.to_list
    |> List.first
    parse(n - value.value, [value.roman_repr | acc])
  end

end
