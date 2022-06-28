defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    opts = get_opts(flags)
    matcher = get_matcher(opts, pattern)
    output = files
    |> Stream.map(&get_file_data/1)
    |> Stream.map(&get_matches(&1, matcher))
    |> Stream.map(&format_matches(&1, opts, Enum.count(files) > 1))
    |> Stream.filter(&(&1 != ""))
    if Enum.any?(output) do
      output
      |> Enum.join("\n")
      |> Kernel.<>("\n")
    else
      ""
    end
  end

  defp get_opts(flags) do
    initial = %{
      line_number?: false,
      file_name?: false,
      case_insensitive?: false,
      invert?: false,
      exact?: false
    }
    flags
    |> Enum.reduce(initial, fn <<"-", value::bitstring>>, acc ->
      case value do
        "n" -> %{acc | line_number?: true}
        "l" -> %{acc | file_name?: true}
        "i" -> %{acc | case_insensitive?: true}
        "v" -> %{acc | invert?: true}
        "x" -> %{acc | exact?: true}
      end
    end)
  end

  defp get_file_data(file) do
    lines = file
    |> File.read!()
    |> String.split("\n")
    enumerated_lines = Stream.iterate(1, &(&1 + 1))
    |> Enum.zip(lines)
    {file, enumerated_lines}
  end

  defp get_matcher(opts, pattern) do
    fn line ->
      {line, pattern} = if opts.case_insensitive? do
        {String.upcase(line), String.upcase(pattern)}
      else
        {line, pattern}
      end
      found? = if opts.exact?, do: line == pattern, else: String.contains?(line, pattern)
      if opts.invert?, do: not found?, else: found?
    end
  end

  defp get_matches({file_name, data_stream}, matcher) do
    {file_name, data_stream |> Stream.filter(fn {_, line} -> matcher.(line) end)}
  end

  defp format_matches({file_name, matches}, opts, multiple_files?) do
    result = if opts.line_number? do
      matches
      |> Stream.filter(&(elem(&1, 1) != ""))
      |> Stream.map(fn {index, line} -> "#{index}:#{line}" end)
    else
      matches
      |> Stream.map(&elem(&1, 1))
      |> Stream.filter(&(&1 != ""))
    end
    result = if multiple_files? do
      result |> Stream.map(&("#{file_name}:#{&1}"))
    else
      result
    end
    if opts.file_name? and Enum.any?(result) do
      file_name
    else
      result
      |> Enum.join("\n")
    end
  end
end
