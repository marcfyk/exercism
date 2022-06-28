defmodule Domino do
  defstruct left: -1, right: -1
  def new(left, right), do: %__MODULE__{left: left, right: right}
end

defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?([{left, right}]), do: left == right
  def chain?([{left, right} | rest]) do
    Enum.any?(rest, fn {next_left, next_right} = d ->
      case {left, right} do
        {left, ^next_left} -> chain?([{left, next_right} | List.delete(rest, d)])
        {left, ^next_right} -> chain?([{left, next_left} | List.delete(rest, d)])
        {^next_left, right} -> chain?([{next_right, right} | List.delete(rest, d)])
        {^next_right, right} -> chain?([{next_left, right} | List.delete(rest, d)])
        _ -> false
      end
    end)
  end

end
