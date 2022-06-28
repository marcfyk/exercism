defmodule LibraryFees do
  def datetime_from_string(string) do
    string
    |> NaiveDateTime.from_iso8601!
  end

  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time
    |> Time.compare(~T"12:00:00")
    == :lt
  end

  def return_date(checkout_datetime) do
    days = if checkout_datetime |> before_noon?,
      do: 28,
      else: 29
    checkout_datetime
    |> NaiveDateTime.add(days * 24 * 60 * 60, :seconds)
    |> NaiveDateTime.to_date
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date
    |> Date.day_of_week()
    == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = checkout |> datetime_from_string
    return_datetime = return |> datetime_from_string
    days = checkout_datetime
    |> return_date
    |> days_late(return_datetime)
    fee = days * rate
    if return_datetime |> monday?,
      do: div(fee, 2),
      else: fee
  end
end
