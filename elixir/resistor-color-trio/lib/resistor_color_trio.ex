defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label([first, second, third]) do
    digits = [first, second]
    |> Enum.map(&value/1)
    |> Kernel.++(List.duplicate(0, value(third)))
    zeros = digits
    |> Enum.count(&(&1 == 0))
    value = Integer.undigits(digits)
    cond do
      zeros >= 3 -> {div(value, 1000), :kiloohms}
      zeros < 3 -> {value, :ohms}
    end
  end

  defp value(:black), do: 0
  defp value(:brown), do: 1
  defp value(:red), do: 2
  defp value(:orange), do: 3
  defp value(:yellow), do: 4
  defp value(:green), do: 5
  defp value(:blue), do: 6
  defp value(:violet), do: 7
  defp value(:grey), do: 8
  defp value(:white), do: 9
end
