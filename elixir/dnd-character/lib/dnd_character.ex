defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score), do: (score - 10) / 2 |> floor

  @spec ability :: pos_integer()
  def ability do
    rolled = Stream.iterate(:rand.uniform(6), fn _ -> :rand.uniform(6) end)
    |> Stream.take(4)
    |> Enum.to_list
    Enum.sum(rolled) - Enum.min(rolled)
  end

  @spec character :: t()
  def character do
    stats = %__MODULE__{
      strength: ability(),
      dexterity: ability(),
      constitution: ability(),
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability(),
    }
    %{stats | hitpoints: 10 + (stats.constitution |> modifier)}
  end
end
