defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts \\ []) do
    validated_opts = {:ok, opts}
    |> validate_positions()
    |> validate_colors()
    |> validate_collisions()
    case validated_opts do
      {:ok, opts} -> %Queens{black: Keyword.get(opts, :black), white: Keyword.get(opts, :white)}
      :error -> raise ArgumentError
    end
  end

  defp valid_index?(index), do: 0 <= index and index < 8
  defp valid_position?({x, y}), do: valid_index?(x) and valid_index?(y)
  defp collision?(p1, p2), do: p1 == p2
  defp valid_keys?(opts) do
    opts
    |> Enum.map(&elem(&1, 0))
    |> Kernel.--([:white, :black])
    |> Enum.empty?()
  end
  defp valid_values(opts) do
    opts
    |> Enum.map(&elem(&1, 1))
    |> Enum.all?(&valid_position?/1)
  end

  defp validate_colors(:error), do: :error
  defp validate_colors({:ok, opts}) do
    case valid_keys?(opts) do
      true -> {:ok, opts}
      false -> :error
    end
  end

  defp validate_positions(:error), do: :error
  defp validate_positions({:ok, opts}) do
    case valid_values(opts) do
      true -> {:ok, opts}
      false -> :error
    end
  end

  defp validate_collisions(:error), do: :error
  defp validate_collisions({:ok, opts}) do
    black = Keyword.get(opts, :black)
    white = Keyword.get(opts, :white)
    case not collision?(black, white) do
      true -> {:ok, opts}
      false -> :error
    end
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    b = queens.black
    w = queens.white
    for i <- 0..7,
        j <- 0..7 do
          case {i, j} do
            ^b -> "B"
            ^w -> "W"
            _ -> "_"
          end
        end
    |> Enum.chunk_every(8)
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{black: nil}), do: false
  def can_attack?(%Queens{white: nil}), do: false
  def can_attack?(queens) do
    {bx, by} = queens.black
    {wx, wy} = queens.white
    cond do
      bx == wx -> true
      by == wy -> true
      abs(bx - wx) == abs(by - wy) -> true
      true -> false
    end
  end
end
