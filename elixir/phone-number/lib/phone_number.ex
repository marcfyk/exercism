defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    raw
    |> validate_characters()
    |> validate_length()
    |> validate_country_code()
    |> validate_area_code()
    |> validate_exchange_code()
    |> validate_subscriber_number()
    |> format_number()
  end

  defp validate_length({:error, _} = error), do: error
  defp validate_length({:ok, length, digits}) do
    case length do
      11 -> {:ok, length, digits}
      10 -> {:ok, length, digits}
      _ -> {:error, "incorrect number of digits"}
    end
  end

  defp validate_characters(text) do
    characters = String.graphemes(text)
    cond do
      Enum.all?(characters, &String.match?(&1, ~r/\d| |-|_|\(|\)|\+|\./)) ->
        digits = Enum.filter(characters, &String.match?(&1, ~r/\d/))
        {:ok, Enum.count(digits), digits}
      true -> {:error, "must contain digits only"}
    end
  end

  defp validate_country_code({:error, _} = error), do: error
  defp validate_country_code({:ok, 10, digits}) do
    {area_code, rest} = Enum.split(digits, 3)
    {exchange_code, subscriber_number} = Enum.split(rest, 3)
    {:ok, area_code, exchange_code, subscriber_number}
  end
  defp validate_country_code({:ok, 11, [country_code | digits]}) do
    case country_code do
      "1" -> validate_country_code({:ok, 10, digits})
      _ -> {:error, "11 digits must start with 1"}
    end
  end

  defp validate_area_code({:error, _} = error), do: error
  defp validate_area_code({:ok, [first, second, third] = area_code, exchange_code, subscriber_number}) do
    cond do
      not String.match?(first, ~r/[2-9]/) -> {:error, "area code cannot start with #{spell(first)}"}
      not String.match?(second, ~r/\d/) -> {:error, ""}
      not String.match?(third, ~r/\d/) -> {:error, ""}
      true -> {:ok, area_code, exchange_code, subscriber_number}
    end
  end

  defp validate_exchange_code({:error, _} = error), do: error
  defp validate_exchange_code({:ok, area_code, [first, second, third] = exchange_code, subscriber_number}) do
    cond do
      not String.match?(first, ~r/[2-9]/) -> {:error, "exchange code cannot start with #{spell(first)}"}
      not String.match?(second, ~r/\d/) -> {:error, ""}
      not String.match?(third, ~r/\d/) -> {:error, ""}
      true -> {:ok, area_code, exchange_code, subscriber_number}
    end
  end

  defp validate_subscriber_number({:error, _} = error), do: error
  defp validate_subscriber_number({:ok, area_code, exchange_code, subscriber_number}) do
    cond do
      Enum.any?(subscriber_number, &(not String.match?(&1, ~r/\d/))) -> {:error, ""}
      true -> {:ok, area_code, exchange_code, subscriber_number}
    end
  end

  defp format_number({:error, _} = error), do: error
  defp format_number({:ok, area_code, exchange_code, subscriber_number}) do
    {
      :ok,
      [area_code, exchange_code, subscriber_number]
      |> Stream.flat_map(&(&1))
      |> Enum.join("")
    }
  end

  defp spell("0"), do: "zero"
  defp spell("1"), do: "one"

end
