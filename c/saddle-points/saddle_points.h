#ifndef SADDLE_POINTS_H
#define SADDLE_POINTS_H

#include <stdint.h>

typedef struct {
  int row;
  int column;
} saddle_point_t;

typedef struct {
  int count;
  saddle_point_t *points;
} saddle_points_t;

saddle_points_t *saddle_points(int rows, int cols, uint8_t matrix[rows][cols]);
void free_saddle_points(saddle_points_t *s);

#endif
