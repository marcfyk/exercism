type planet =
  | Mercury
  | Venus
  | Earth
  | Mars
  | Jupiter
  | Saturn
  | Neptune
  | Uranus

let year_factor = function
  | Mercury -> 0.2408467
  | Venus -> 0.61519726
  | Earth -> 1.
  | Mars -> 1.8808158
  | Jupiter -> 11.862615
  | Saturn -> 29.447498
  | Uranus -> 84.016846
  | Neptune -> 164.79132

let seconds_to_year s = s /. 60. /. 60. /. 24. /. 365.

let age_on planet seconds =
  float_of_int seconds /. year_factor planet |> seconds_to_year
