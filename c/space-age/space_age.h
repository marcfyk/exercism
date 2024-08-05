#ifndef SPACE_AGE_H
#define SPACE_AGE_H

#include <stdint.h>

typedef enum planet {
  MERCURY,
  VENUS,
  EARTH,
  MARS,
  JUPITER,
  SATURN,
  URANUS,
  NEPTUNE,
} planet_t;

#define EARTH_YEARS_MERCURY 0.2408467
#define EARTH_YEARS_VENUS 0.61519726
#define EARTH_YEARS_EARTH 1
#define EARTH_YEARS_MARS 1.8808158
#define EARTH_YEARS_JUPITER 11.862615
#define EARTH_YEARS_SATURN 29.447498
#define EARTH_YEARS_URANUS 84.016846
#define EARTH_YEARS_NEPTUNE 164.79132

#define EARTH_SECONDS_TO_YEARS 31557600

float age(const planet_t planet, const int64_t seconds);

#endif
