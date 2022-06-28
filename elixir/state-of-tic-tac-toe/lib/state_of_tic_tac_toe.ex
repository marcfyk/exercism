defmodule StateOfTicTacToe do
  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """
  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board) do
    board
    |> parse_table()
    |> validate_turns()
    |> verify_state()
  end

  defp parse_table(board) do
    board
    |> String.split("\n")
    |> Stream.filter(&(&1 != ""))
    |> Stream.map(&String.graphemes/1)
    |> fn data -> {:ok, data} end.()
  end

  defp validate_turns({:ok, table}) do
    table
    |> Stream.flat_map(&(&1))
    |> Enum.frequencies()
    |> fn freq -> {Map.get(freq, "X", 0), Map.get(freq, "O", 0)} end.()
    |> fn {x, o} ->
      cond do
        x - o > 1 -> {:error, "Wrong turn order: X went twice"}
        x - o <= -1 -> {:error, "Wrong turn order: O started"}
        true -> {:ok, table, x, o}
      end
    end.()
  end

  defp verify_state({:error, _} = err), do: err
  defp verify_state({:ok, table, x_count, o_count}) do
    x_win = x_win?(table)
    o_win = o_win?(table)
    cond do
      x_win and o_win -> {:error, "Impossible board: game should have ended after the game was won"}
      x_win -> {:ok, :win}
      o_win -> {:ok, :win}
      (x_count + o_count) == 9 -> {:ok, :draw}
      true -> {:ok, :ongoing}
    end
  end

  defp x_win?(table), do: win?(table, "X")
  defp o_win?(table), do: win?(table, "O")
  defp win?(table, letter) do
    row_win? = table
    |> Enum.any?(&Enum.all?(&1, fn x -> x == letter end))
    col_win? = table
    |> Stream.zip()
    |> Stream.map(&Tuple.to_list/1)
    |> Enum.any?(&Enum.all?(&1, fn x -> x == letter end))
    diagonal_win? = table
    |> Enum.map(&List.to_tuple/1)
    |> List.to_tuple()
    |> fn data ->
      get = fn i, j -> data |> elem(i) |> elem(j) end
      match_cell? = fn i, j -> get.(i, j) == letter end
      match_cell?.(1, 1) and ((match_cell?.(0, 0) and match_cell?.(2, 2)) or (match_cell?.(2, 0) and match_cell?.(0, 2)))
    end.()
    row_win? or col_win? or diagonal_win?
  end
end
