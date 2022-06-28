defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory
    |> Enum.sort_by(fn x -> x.price end)
  end

  def with_missing_price(inventory) do
    inventory
    |> Enum.filter(fn x -> is_nil(x.price) end)
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(fn x -> 
      %{x | name: String.replace(x.name, old_word, new_word)}
    end)
  end

  def increase_quantity(item, count) do
    updated_quantities = item.quantity_by_size
    |> Map.new(fn {k, v} -> {k, v + count} end)
    %{item | quantity_by_size: updated_quantities}
  end

  def total_quantity(item) do
    item.quantity_by_size
    |> Enum.reduce(0, fn {_, v}, acc -> acc + v end)
  end
end
