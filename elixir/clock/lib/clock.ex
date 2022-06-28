defmodule Clock do
  defstruct hour: 0, minute: 0

  @hours 24
  @minutes 60

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    %Clock{}
    |> add(minute + hour * @minutes)
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    hour * @minutes + minute + add_minute
    |> get_clock()
  end

  defp get_clock(minutes) when minutes >= 0 do
    hours = rem(div(minutes, @minutes), @hours)
    minutes = rem(minutes, @minutes)
    %Clock{hour: hours, minute: minutes}
  end

  defp get_clock(minutes) when minutes < 0 do
    hours = @hours - rem(div(abs(minutes), @minutes), @hours)
    minutes = rem(@minutes - rem(minutes, @minutes), @minutes)
    cond do
      minutes > 0 -> %Clock{hour: rem(hours - 1, @hours), minute: @minutes - minutes}
      true -> %Clock{hour: hours, minute: minutes}
    end
  end

  defimpl String.Chars, for: Clock do
    def to_string(%Clock{hour: hour, minute: minute}) do
      format_hour = hour
      |> Integer.to_string()
      |> String.pad_leading(2, "0")
      format_minute = minute
      |> Integer.to_string()
      |> String.pad_leading(2, "0")
      "#{format_hour}:#{format_minute}"
    end
  end
end
