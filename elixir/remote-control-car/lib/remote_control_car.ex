defmodule RemoteControlCar do

  @enforce_keys [:nickname]
  defstruct [
    :nickname,
    battery_percentage: 100,
    distance_driven_in_meters: 0
  ]

  def new(nickname \\ "none") do
    %__MODULE__{
      nickname: nickname,
      battery_percentage: 100,
      distance_driven_in_meters: 0
  }
  end

  def display_distance(%__MODULE__{
    nickname: _,
    distance_driven_in_meters: distance,
    battery_percentage: _,
  }) do
    "#{distance} meters"
  end

  def display_battery(%__MODULE__{
    nickname: _,
    distance_driven_in_meters: _,
    battery_percentage: battery,
  }) do
    if battery > 0,
      do: "Battery at #{battery}%",
      else: "Battery empty"
  end

  def drive(%__MODULE__{
    nickname: nickname,
    distance_driven_in_meters: distance,
    battery_percentage: battery,
  }) do
    if battery > 0,
      do: %__MODULE__{
        nickname: nickname,
        distance_driven_in_meters: distance + 20,
        battery_percentage: battery - 1
      },
      else: %__MODULE__{
        nickname: nickname,
        distance_driven_in_meters: distance,
        battery_percentage: battery
      }
  end
end
