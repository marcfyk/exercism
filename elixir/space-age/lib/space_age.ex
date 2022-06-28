defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) do
    years = seconds
    |> seconds_to_years
    |> planet_years(planet)
    case years do
      :error -> {:error, "not a planet"}
      result -> {:ok, result}
    end
  end

  defp seconds_to_years(seconds), do: seconds / 31557600

  defp planet_years(years, :mercury), do: years / 0.2408467
  defp planet_years(years, :venus), do: years / 0.61519726
  defp planet_years(years, :earth), do: years / 1.0
  defp planet_years(years, :mars), do: years / 1.8808158
  defp planet_years(years, :jupiter), do: years / 11.862615
  defp planet_years(years, :saturn), do: years / 29.447498
  defp planet_years(years, :uranus), do: years / 84.016846
  defp planet_years(years, :neptune), do: years / 164.79132
  defp planet_years(_, _), do: :error

end
