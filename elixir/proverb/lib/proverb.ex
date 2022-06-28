defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite(strings) do
    strings
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.map(fn [x, y] -> sentence(x, y) end)
    |> Kernel.++([strings |> List.first() |> ending()])
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end

  defp sentence(x, y), do: "For want of a #{x} the #{y} was lost."
  defp ending(x), do: "And all for the want of a #{x}."

end
