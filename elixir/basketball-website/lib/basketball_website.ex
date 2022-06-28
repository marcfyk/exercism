defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path
    |> String.split(".")
    |> Enum.reduce(data, fn key, acc -> acc[key] end)
  end

  def get_in_path(data, path) do
    keys = path |> String.split(".")
    data |> get_in(keys)
  end
end
