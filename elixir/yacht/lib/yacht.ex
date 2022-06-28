defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer

  def score(:ones, dice), do: dice |> Stream.filter(&(&1 == 1)) |> Enum.sum()

  def score(:twos, dice), do: dice |> Stream.filter(&(&1 == 2)) |> Enum.sum()

  def score(:threes, dice), do: dice |> Stream.filter(&(&1 == 3)) |> Enum.sum()

  def score(:fours, dice), do: dice |> Stream.filter(&(&1 == 4)) |> Enum.sum()

  def score(:fives, dice), do: dice |> Stream.filter(&(&1 == 5)) |> Enum.sum()

  def score(:sixes, dice), do: dice |> Stream.filter(&(&1 == 6)) |> Enum.sum()

  def score(:full_house, dice) do
    case Enum.sort(dice) do
      [n, n, n, m, m] when n != m -> Enum.sum(dice)
      [m, m, n, n, n] when n != m -> Enum.sum(dice)
      _ -> 0
    end
  end

  def score(:four_of_a_kind, dice) do
    case Enum.sort(dice) do
      [n, n, n, n, _] -> n * 4
      [_, n, n, n, n] -> n * 4
      _ -> 0
    end
  end

  def score(:little_straight, dice) do
    case Enum.frequencies(dice) do
      %{1 => 1, 2 => 1, 3 => 1, 4 => 1, 5 => 1} -> 30
      _ -> 0
    end
  end

  def score(:big_straight, dice) do
    case Enum.frequencies(dice) do
      %{2 => 1, 3 => 1, 4 => 1, 5 => 1, 6 => 1} -> 30
      _ -> 0
    end
  end

  def score(:choice, dice), do: Enum.sum(dice)

  def score(:yacht, dice) do
    case dice do
      [n, n, n, n, n] -> 50
      _ -> 0
    end
  end

end
