defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    data = get_data(texts)
    chunk_size = get_data_chunk_size(data, workers)
    data
    |> Stream.chunk_every(chunk_size)
    |> Task.async_stream(&Enum.frequencies/1)
    |> Stream.map(&elem(&1, 1))
    |> Enum.reduce(Map.new(), &merge_maps/2)
  end

  defp get_data(texts) do
    texts
    |> Enum.join()
    |> String.graphemes()
    |> Stream.filter(&String.match?(&1, ~r/\p{L}/))
    |> Stream.map(&String.downcase/1)
  end

  defp get_data_chunk_size(data_stream, workers) do
    data_stream
    |> Enum.count()
    |> Kernel./(workers)
    |> ceil()
    |> max(1)
  end

  defp merge_maps(x, y) do
    Enum.reduce(x, y, fn {letter, count}, acc ->
      Map.update(acc, letter, count, &(&1 + count))
    end)
  end

end
