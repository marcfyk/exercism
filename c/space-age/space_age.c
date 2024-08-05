#include "space_age.h"

float age(const planet_t planet, const int64_t seconds) {
  float ratio;
  switch (planet) {
  case MERCURY:
    ratio = EARTH_YEARS_MERCURY;
    break;
  case VENUS:
    ratio = EARTH_YEARS_VENUS;
    break;
  case EARTH:
    ratio = EARTH_YEARS_EARTH;
    break;
  case MARS:
    ratio = EARTH_YEARS_MARS;
    break;
  case JUPITER:
    ratio = EARTH_YEARS_JUPITER;
    break;
  case SATURN:
    ratio = EARTH_YEARS_SATURN;
    break;
  case URANUS:
    ratio = EARTH_YEARS_URANUS;
    break;
  case NEPTUNE:
    ratio = EARTH_YEARS_NEPTUNE;
    break;
  default:
    return -1;
  }
  const float earth_years = (float)seconds / EARTH_SECONDS_TO_YEARS;
  return earth_years / ratio;
}
