defmodule Line do
  defstruct [:subject, :verb]

  def format(line, starting?, ending?) do
    line
    |> sentence_structure(starting?)
    |> add_ending(ending?)
  end

  defp sentence_structure(line, starting?) do
    if starting?,
      do: "This is the #{line.subject}",
      else: "that #{line.verb} the #{line.subject}"
  end

  defp add_ending(sentence, ending?) do
    if ending?,
      do: sentence <> ".",
      else: sentence
  end

end

defmodule House do

  @lines {
    %Line{
      subject: "house that Jack built",
      verb: "lay in",
    },
    %Line{
      subject: "malt",
      verb: "ate",
    },
    %Line{
      subject: "rat",
      verb: "killed",
    },
    %Line{
      subject: "cat",
      verb: "worried",
    },
    %Line{
      subject: "dog",
      verb: "tossed",
    },
    %Line{
      subject: "cow with the crumpled horn",
      verb: "milked",
    },
    %Line{
      subject: "maiden all forlorn",
      verb: "kissed",
    },
    %Line{
      subject: "man all tattered and torn",
      verb: "married",
    },
    %Line{
      subject: "priest all shaven and shorn",
      verb: "woke",
    },
    %Line{
      subject: "rooster that crowed in the morn",
      verb: "kept",
    },
    %Line{
      subject: "farmer sowing his corn",
      verb: "belonged to",
    },
    %Line{
      subject: "horse and the hound and the horn",
      verb: "",
    },
  }

  defp get_base_sentence(start, stop) when start == stop do
    @lines
    |> elem(start - 1)
    |> Line.format(true, true)
  end
  defp get_base_sentence(start, stop), do: get_base_sentence(start, stop, stop, [])

  defp get_base_sentence(start, _, index, acc) when index > start, do: acc |> Enum.join(" ")
  defp get_base_sentence(start, stop, index, acc) when index == start do
    line = @lines
    |> elem(index - 1)
    |> Line.format(true, false)
    get_base_sentence(start, stop, index + 1, [line | acc])
  end
  defp get_base_sentence(start, stop, index, acc) when index == stop do
    line = @lines
    |> elem(index - 1)
    |> Line.format(false, true)
    get_base_sentence(start, stop, index + 1, [line | acc])
  end
  defp get_base_sentence(start, stop, index, acc) do
    line = @lines
    |> elem(index - 1)
    |> Line.format(false, false)
    get_base_sentence(start, stop, index + 1, [line | acc])
  end



  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    start..stop
    |> Stream.map(&get_base_sentence(&1, 1))
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end
end
