defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    week_index = get_week_index(weekday)
    day = get_date_range(schedule)
    |> Enum.find(&get_date(week_index, year, month, &1))
    Date.new(year, month, day)
    |> elem(1)
  end

  defp get_week_index(:monday), do: 1
  defp get_week_index(:tuesday), do: 2
  defp get_week_index(:wednesday), do: 3
  defp get_week_index(:thursday), do: 4
  defp get_week_index(:friday), do: 5
  defp get_week_index(:saturday), do: 6
  defp get_week_index(:sunday), do: 7

  defp get_date_range(:first), do: 1..7
  defp get_date_range(:second), do: 8..14
  defp get_date_range(:third), do: 15..21
  defp get_date_range(:fourth), do: 22..28
  defp get_date_range(:last), do: 31..22
  defp get_date_range(:teenth), do: 13..19

  defp get_date(index, year, month, day) do
    case Date.new(year, month, day) do
      {:ok, date} -> Date.day_of_week(date) === index
      _ -> false
    end
  end

end
