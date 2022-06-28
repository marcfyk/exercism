defmodule DateParser do
  def day() do
    "(\\d{1,2})"
  end

  def month() do
    "(\\d{1,2})"
  end

  def year() do
    "(\\d{4})"
  end

  def day_names() do
    "(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)"
  end

  def month_names() do
    "(January|February|March|April|May|June|July|August|September|October|November|December)"
  end

  def capture_day() do
    "(?<day>#{day()})"
  end

  def capture_month() do
    "(?<month>#{month()})"
  end

  def capture_year() do
    "(?<year>#{year()})"
  end

  def capture_day_name() do
    "(?<day_name>#{day_names()})"
  end

  def capture_month_name() do
    "(?<month_name>#{month_names()})"
  end

  def capture_numeric_date() do
    day = capture_day()
    month = capture_month()
    year = capture_year()
    "^#{day}/#{month}/#{year}$"
  end

  def capture_month_name_date() do
    month_name = capture_month_name()
    day = capture_day()
    year = capture_year()
    "^#{month_name} #{day}, #{year}$"
  end

  def capture_day_month_name_date() do
    day_name = capture_day_name()
    month_name = capture_month_name()
    day = capture_day()
    year = capture_year()
    "^#{day_name}, #{month_name} #{day}, #{year}$"
  end

  def match_numeric_date() do
    capture_numeric_date() |> Regex.compile!()
  end

  def match_month_name_date() do
    capture_month_name_date() |> Regex.compile!()
  end

  def match_day_month_name_date() do
    capture_day_month_name_date() |> Regex.compile!()
  end
end
