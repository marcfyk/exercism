defmodule Chessboard do
  def rank_range do
    1..8
  end

  def file_range do
    ?A..?H
  end

  def ranks do
    rank_range()
    |> Enum.into([])
  end

  def files do
    file_range()
    |> Enum.map(fn x -> <<x>> end)
    |> Enum.into([])
  end
end
