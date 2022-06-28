defmodule Bob do

  defp uppercase?(text) do
    text |> String.upcase == text and text |> String.downcase != text
  end

  defp ends_with_question?(text) do
    text |> String.ends_with?("?")
  end

  @spec hey(String.t()) :: String.t()
  def hey(input) do
    text = input |> String.trim
    cond do
      text == "" -> "Fine. Be that way!"
      uppercase?(text) and ends_with_question?(text) -> "Calm down, I know what I'm doing!"
      uppercase?(text) -> "Whoa, chill out!"
      ends_with_question?(text) -> "Sure."
      true -> "Whatever."
    end
  end
end
