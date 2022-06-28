defmodule Game do
  defstruct [:p1, :p2, :status]
end

defimpl Collectable, for: Game do
  def into(game) do
    collector = fn
      acc, {:cont, {key, value}} -> Map.put(acc, String.to_atom(key), String.to_atom(value))
      acc, :done -> acc
      _, :halt -> :ok
    end
    {game, collector}
  end
end

defmodule TeamData do
  defstruct [wins: 0, draws: 0, losses: 0]

  @header String.pad_trailing("Team", 30, " ")
  |> Kernel.<>(" | MP")
  |> Kernel.<>(" |  W")
  |> Kernel.<>(" |  D")
  |> Kernel.<>(" |  L")
  |> Kernel.<>(" |  P")

  defp matches_played(team_data) do
    Enum.sum([team_data.wins, team_data.draws, team_data.losses])
  end

  defp points(team_data) do
    [team_data.wins, team_data.draws, team_data.losses]
    |> Stream.zip([3, 1, 0])
    |> Stream.map(&(elem(&1, 0) * elem(&1, 1)))
    |> Enum.sum()
  end

  def calculate_team_data(games) do
    games
    |> Enum.reduce(%{}, &update_team_data/2)
  end

  def aggregate_data(data) do
    data
    |> Stream.map(&aggregate/1)
  end

  def format_data(data) do
    rows = data
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.sort_by(&elem(&1, 1).points, :desc)
    |> Enum.map(&format/1)
    [@header | rows]
    |> Enum.join("\n")
  end

  defp format({name, team_data}) do
    String.pad_trailing("#{name}", 30, " ")
    |> Kernel.<>(" | #{pad_data_field(team_data.matches_played)}")
    |> Kernel.<>(" | #{pad_data_field(team_data.wins)}")
    |> Kernel.<>(" | #{pad_data_field(team_data.draws)}")
    |> Kernel.<>(" | #{pad_data_field(team_data.losses)}")
    |> Kernel.<>(" | #{pad_data_field(team_data.points)}")
  end

  defp pad_data_field(field) do
    field
    |> Integer.to_string()
    |> String.pad_leading(2, " ")
  end

  defp aggregate({name, team_data}) do
    {
      name,
      team_data
      |> Map.put(:matches_played, matches_played(team_data))
      |> Map.put(:points, points(team_data))
    }
  end

  defp update_team_data(game, total_data) when game.status == :win do
    total_data
    |> Map.put_new(game.p1, %TeamData{})
    |> Map.put_new(game.p2, %TeamData{})
    |> Map.update!(game.p1, &win/1)
    |> Map.update!(game.p2, &lose/1)
  end

  defp update_team_data(game, total_data) when game.status == :draw do
    total_data
    |> Map.put_new(game.p1, %TeamData{})
    |> Map.put_new(game.p2, %TeamData{})
    |> Map.update!(game.p1, &draw/1)
    |> Map.update!(game.p2, &draw/1)
  end

  defp update_team_data(game, total_data) when game.status == :loss do
    total_data
    |> Map.put_new(game.p1, %TeamData{})
    |> Map.put_new(game.p2, %TeamData{})
    |> Map.update!(game.p1, &lose/1)
    |> Map.update!(game.p2, &win/1)
  end

  defp win(team_data), do: %{team_data | wins: team_data.wins + 1}
  defp draw(team_data), do: %{team_data | draws: team_data.draws + 1}
  defp lose(team_data), do: %{team_data | losses: team_data.losses + 1}
end

defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Stream.map(&parse_line/1)
    |> Stream.filter(&(&1 != :error))
    |> Stream.map(&elem(&1, 1))
    |> TeamData.calculate_team_data()
    |> TeamData.aggregate_data()
    |> TeamData.format_data()
  end

  defp parse_line(line) do
    regex = ~r/^(?<p1>.*);(?<p2>.*);(?<status>win|draw|loss)$/
    cond do
      not Regex.match?(regex, line) -> :error
      true ->
        {
          :ok,
          regex
          |> Regex.named_captures(line)
          |> Enum.into(%Game{})
        }
    end
  end

end
