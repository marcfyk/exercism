defmodule OcrNumbers do
  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """

  @width 3
  @height 4

  @zero [
    [" ", "_", " "],
    ["|", " ", "|"],
    ["|", "_", "|"],
    [" ", " ", " "],
  ]

  @one [
    [" ", " ", " "],
    [" ", " ", "|"],
    [" ", " ", "|"],
    [" ", " ", " "],
  ]

  @two [
    [" ", "_", " "],
    [" ", "_", "|"],
    ["|", "_", " "],
    [" ", " ", " "],
  ]

  @three [
    [" ", "_", " "],
    [" ", "_", "|"],
    [" ", "_", "|"],
    [" ", " ", " "],
  ]

  @four [
    [" ", " ", " "],
    ["|", "_", "|"],
    [" ", " ", "|"],
    [" ", " ", " "],
  ]

  @five [
    [" ", "_", " "],
    ["|", "_", " "],
    [" ", "_", "|"],
    [" ", " ", " "],
  ]

  @six [
    [" ", "_", " "],
    ["|", "_", " "],
    ["|", "_", "|"],
    [" ", " ", " "],
  ]

  @seven [
    [" ", "_", " "],
    [" ", " ", "|"],
    [" ", " ", "|"],
    [" ", " ", " "],
  ]

  @eight [
    [" ", "_", " "],
    ["|", "_", "|"],
    ["|", "_", "|"],
    [" ", " ", " "],
  ]

  @nine [
    [" ", "_", " "],
    ["|", "_", "|"],
    [" ", "_", "|"],
    [" ", " ", " "],
  ]

  @spec convert([String.t()]) :: {:ok, String.t()} | {:error, String.t()}
  def convert(input) do
    {:ok, input}
    |> parse_rows()
    |> validate_rows()
    |> parse_cols()
    |> validate_cols()
    |> partition_numbers()
  end

  defp parse_rows({:error, _} = err), do: err
  defp parse_rows({:ok, input}) do
    input
    |> Stream.map(&String.graphemes/1)
    |> Stream.chunk_every(@height)
    |> fn rows -> {:ok, rows} end.()
  end

  defp validate_rows({:error, _} = err), do: err
  defp validate_rows({:ok, rows}) do
    error? = rows
    |> Stream.map(&Enum.count/1)
    |> Enum.any?(&(&1 != @height))
    case error? do
      true -> {:error, "invalid line count"}
      false -> {:ok, rows}
    end
  end

  defp parse_cols({:error, _} = err), do: err
  defp parse_cols({:ok, rows}) do
    rows
    |> Stream.map(fn four_rows ->
      Stream.map(four_rows, &Enum.chunk_every(&1, @width))
    end)
    |> fn rows -> {:ok, rows} end.()
  end

  defp validate_cols({:error, _} = err), do: err
  defp validate_cols({:ok, rows}) do
    error? = rows
    |> Stream.flat_map(&(&1))
    |> Stream.flat_map(&(&1))
    |> Stream.map(&Enum.count/1)
    |> Stream.map(&Kernel.rem(&1, @width))
    |> Enum.any?(&(&1 > 0))
    case error? do
      true -> {:error, "invalid column count"}
      false -> {:ok, rows}
    end
  end

  defp partition_numbers({:error, _} = err), do: err
  defp partition_numbers({:ok, rows}) do
    rows
    |> Stream.map(fn four_rows ->
      four_rows
      |> Stream.zip()
      |> Stream.map(&Tuple.to_list/1)
      |> Stream.map(&parse_number/1)
      |> Enum.join("")
    end)
    |> Enum.join(",")
    |> fn result -> {:ok, result} end.()
  end

  defp parse_number(@zero), do: "0"
  defp parse_number(@one), do: "1"
  defp parse_number(@two), do: "2"
  defp parse_number(@three), do: "3"
  defp parse_number(@four), do: "4"
  defp parse_number(@five), do: "5"
  defp parse_number(@six), do: "6"
  defp parse_number(@seven), do: "7"
  defp parse_number(@eight), do: "8"
  defp parse_number(@nine), do: "9"
  defp parse_number(_), do: "?"
end
