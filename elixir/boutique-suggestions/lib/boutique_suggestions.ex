defmodule BoutiqueSuggestions do


  def get_combinations(tops, bottoms, options \\ []) do
    for top <- tops,
        bottom <- bottoms,
        Map.get(top, :base_color) != Map.get(bottom, :base_color),
        Keyword.get(options, :maximum_price, 100) >= (Map.get(top, :price) + Map.get(bottom, :price)),
        do: {top, bottom}
  end
end
