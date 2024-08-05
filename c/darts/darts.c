#include "darts.h"
#include <math.h>
#include <stdint.h>

uint8_t score(const coordinate_t landing_position) {
  const double distance = sqrt(landing_position.x * landing_position.x +
                               landing_position.y * landing_position.y);
  if (distance <= RADIUS_INNER) {
    return SCORE_INNER;
  } else if (distance <= RADIUS_MIDDLE) {
    return SCORE_MIDDLE;
  } else if (distance <= RADIUS_OUTER) {
    return SCORE_OUTER;
  } else {
    return SCORE_ZERO;
  }
}
