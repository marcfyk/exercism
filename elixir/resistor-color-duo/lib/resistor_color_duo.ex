defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value(colors) do
    colors
    |> Stream.take(2)
    |> Stream.map(&resistance/1)
    |> Stream.map(&to_string/1)
    |> Enum.reduce(&(&2 <> &1))
    |> Integer.parse
    |> elem(0)
  end

  defp resistance(:black), do: 0
  defp resistance(:brown), do: 1
  defp resistance(:red), do: 2
  defp resistance(:orange), do: 3
  defp resistance(:yellow), do: 4
  defp resistance(:green), do: 5
  defp resistance(:blue), do: 6
  defp resistance(:violet), do: 7
  defp resistance(:grey), do: 8
  defp resistance(:white), do: 9
  
end
