defmodule KitchenCalculator do
  def get_volume({_, volume}) do
    volume
  end

  def to_milliliter(volume_pair) do
    case volume_pair do
      {:cup, volume} -> {:milliliter, volume * 240}
      {:fluid_ounce, volume} -> {:milliliter, volume * 30}
      {:teaspoon, volume} -> {:milliliter, volume * 5}
      {:tablespoon, volume} -> {:milliliter, volume * 15}
      {:milliliter, volume} -> {:milliliter, volume}
    end
  end

  def from_milliliter(volume_pair, unit) do
    volume = get_volume(volume_pair)
    updated_volume = case unit do
      :cup -> volume / 240
      :fluid_ounce -> volume / 30
      :teaspoon -> volume / 5
      :tablespoon -> volume / 15
      :milliliter -> volume
    end
    {unit, updated_volume}
  end

  def convert(volume_pair, unit) do
    from_milliliter(to_milliliter(volume_pair), unit)
  end
end
