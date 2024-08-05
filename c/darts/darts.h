#ifndef DARTS_H
#define DARTS_H

#include <stdint.h>

typedef enum {
  RADIUS_OUTER = 10,
  RADIUS_MIDDLE = 5,
  RADIUS_INNER = 1,
} radius_t;

typedef enum {
  SCORE_ZERO = 0,
  SCORE_OUTER = 1,
  SCORE_MIDDLE = 5,
  SCORE_INNER = 10,
} score_t;

typedef struct {
  double x;
  double y;
} coordinate_t;

uint8_t score(const coordinate_t landing_position);

#endif
