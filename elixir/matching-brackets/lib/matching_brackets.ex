defmodule MatchingBrackets do
  @round_bracket_open "("
  @round_bracket_close ")"

  @square_bracket_open "["
  @square_bracket_close "]"

  @curly_bracket_open "{"
  @curly_bracket_close "}"

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.graphemes()
    |> Enum.reduce([], fn
      c, acc -> case {c, acc} do
        {_, :error} -> :error
        {@round_bracket_open, _} -> [@round_bracket_open | acc]
        {@square_bracket_open, _} -> [@square_bracket_open | acc]
        {@curly_bracket_open, _} -> [@curly_bracket_open | acc]
        {@round_bracket_close, [@round_bracket_open | t]} -> t
        {@round_bracket_close, _} -> :error
        {@square_bracket_close, [@square_bracket_open | t]} -> t
        {@square_bracket_close, _} -> :error
        {@curly_bracket_close, [@curly_bracket_open | t]} -> t
        {@curly_bracket_close, _} -> :error
        {_, _} -> acc
      end
    end)
    |> Kernel.==([])
  end
end
