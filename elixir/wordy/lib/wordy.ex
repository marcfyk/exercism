defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) do
    question
    |> parse_question()
    |> validate_prefix_format()
    |> validate_suffix_question()
    |> parse_operators()
    |> validate_operators()
    |> evaluate()
    |> format()
  end

  defp parse_question(question) do
    question
    |> String.replace("plus", "+")
    |> String.replace("minus", "-")
    |> String.replace("multiplied by", "*")
    |> String.replace("divided by", "/")
    |> String.split(" ", trim: true)
    |> fn tokens -> {:ok, tokens} end.()
  end

  defp validate_prefix_format(:error), do: :error
  defp validate_prefix_format({:ok, tokens}) do
    case tokens do
      ["What", "is" | tail] -> {:ok, tail}
      _ -> :error
    end
  end

  defp validate_suffix_question(:error), do: :error
  defp validate_suffix_question({:ok, tokens}) do
    last = tokens |> List.last()
    case last |> String.reverse() do
      "?" <> reversed ->
        rest = tokens
        |> Enum.reverse()
        |> tl()
        [reversed |> String.reverse() | rest]
        |> Enum.reverse()
        |> fn parsed -> {:ok, parsed} end.()
      _ -> :error
    end
  end

  defp parse_operators(:error), do: :error
  defp parse_operators({:ok, tokens}) do
    tokens
    |> Enum.map(fn
      "+" -> :add
      "-" -> :subtract
      "*" -> :multiply
      "/" -> :divide
      token -> case Integer.parse(token) do
        {number, ""} -> number
        _ -> :error
      end
    end)
    |> Enum.reduce({:ok, []}, fn
      _, :error -> :error
      :error, _ -> :error
      token, {:ok, tokens} -> {:ok, [token | tokens]}
    end)
    |> fn
      {:ok, tokens} -> {:ok, tokens |> Enum.reverse() }
      :error -> :error
    end.()
  end

  defp operator?(:add), do: true
  defp operator?(:minus), do: true
  defp operator?(:multiply), do: true
  defp operator?(:divide), do: true
  defp operator?(_), do: false

  defp validate_operators(:error), do: :error
  defp validate_operators({:ok, tokens}) do
    [head | tail] = tokens
    tail
    |> Enum.reduce({:ok, head}, fn
      _, :error -> :error
      token, {:ok, value} ->
        cond do
          operator?(token) and operator?(value) -> :error
          true -> {:ok, token}
        end
    end)
    |> fn
      :error -> :error
      _ -> {:ok, tokens}
    end.()
  end


  defp evaluate(:error), do: :error
  defp evaluate({:ok, tokens}) do
    case tokens do
      [var_one, :add, var_two | tail] -> evaluate({:ok, [var_one + var_two | tail]})
      [var_one, :subtract, var_two | tail] -> evaluate({:ok, [var_one - var_two | tail]})
      [var_one, :multiply, var_two | tail] -> evaluate({:ok, [var_one * var_two | tail]})
      [var_one, :divide, var_two | tail] -> evaluate({:ok, [div(var_one,var_two) | tail]})
      [result] -> {:ok, result}
      _ -> :error
    end
  end

  defp format(:error), do: raise ArgumentError
  defp format({:ok, result}), do: result
end
