defmodule Day do
  @enforce_keys [:number, :item]
  defstruct [:number, :item]
end

defmodule TwelveDays do

  @days {
    %Day{number: 1, item: "Partridge in a Pear Tree"},
    %Day{number: 2, item: "Turtle Doves"},
    %Day{number: 3, item: "French Hens"},
    %Day{number: 4, item: "Calling Birds"},
    %Day{number: 5, item: "Gold Rings"},
    %Day{number: 6, item: "Geese-a-Laying"},
    %Day{number: 7, item: "Swans-a-Swimming"},
    %Day{number: 8, item: "Maids-a-Milking"},
    %Day{number: 9, item: "Ladies Dancing"},
    %Day{number: 10, item: "Lords-a-Leaping"},
    %Day{number: 11, item: "Pipers Piping"},
    %Day{number: 12, item: "Drummers Drumming"},
  }

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(1) do
    day = @days |> elem(0)
    "On the #{day(day.number)} day of Christmas my true love gave to me: #{count(day.number)} #{day.item}."
  end
  def verse(number) do
    @days
    |> elem(number - 1)
    |> format()
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Stream.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing, do: verses(1, 12)

  defp count(1), do: "a"
  defp count(2), do: "two"
  defp count(3), do: "three"
  defp count(4), do: "four"
  defp count(5), do: "five"
  defp count(6), do: "six"
  defp count(7), do: "seven"
  defp count(8), do: "eight"
  defp count(9), do: "nine"
  defp count(10), do: "ten"
  defp count(11), do: "eleven"
  defp count(12), do: "twelve"

  defp day(1), do: "first"
  defp day(2), do: "second"
  defp day(3), do: "third"
  defp day(4), do: "fourth"
  defp day(5), do: "fifth"
  defp day(6), do: "sixth"
  defp day(7), do: "seventh"
  defp day(8), do: "eighth"
  defp day(9), do: "ninth"
  defp day(10), do: "tenth"
  defp day(11), do: "eleventh"
  defp day(12), do: "twelfth"

  defp describe_item(day), do: "#{count(day.number)} #{day.item}"

  defp get_item_sequence(1) do
    @days
    |> elem(0)
    |> describe_item()
  end
  defp get_item_sequence(n) when n > 1 do
    n-1..1
    |> Stream.map(&elem(@days, &1))
    |> Stream.map(&describe_item/1)
    |> Enum.join(", ")
    |> Kernel.<>(", and #{get_item_sequence(1)}")
  end
  defp format(day) do
    "On the #{day(day.number)} day of Christmas my true love gave to me: #{get_item_sequence(day.number)}."
  end
end
