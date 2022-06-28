defmodule Allergies do
  @allergens [:eggs, :peanuts, :shellfish, :strawberries, :tomatoes, :chocolate, :pollen, :cats]

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    @allergens
    |> Stream.zip(little_endian_bits(flags))
    |> Stream.filter(fn {_, bit} -> bit == 1 end)
    |> Stream.map(fn {allergen, _} -> "#{allergen}" end)
    |> Enum.to_list()
  end

  defp little_endian_bits(number) do
    number
    |> Integer.digits(2)
    |> Enum.reverse()
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item), do: item in list(flags)
end
