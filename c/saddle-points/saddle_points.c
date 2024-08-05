#include "saddle_points.h"
#include <stdlib.h>

saddle_points_t *saddle_points(int rows, int cols, uint8_t matrix[rows][cols]) {
  saddle_points_t *s = malloc(sizeof(saddle_points_t));
  s->count = 0;
  if (rows <= 0 || cols <= 0) {
    s->points = NULL;
    return s;
  }
  int *max_rows = malloc(sizeof(int) * rows);
  int *min_cols = malloc(sizeof(int) * cols);
  for (int i = 0; i < rows; ++i) {
    int max = matrix[i][0];
    for (int j = 0; j < cols; ++j) {
      max = max > matrix[i][j] ? max : matrix[i][j];
    }
    max_rows[i] = max;
  }
  for (int i = 0; i < cols; ++i) {
    int min = matrix[0][i];
    for (int j = 0; j < rows; ++j) {
      min = min < matrix[j][i] ? min : matrix[j][i];
    }
    min_cols[i] = min;
  }

  for (int i = 0; i < rows; ++i) {
    for (int j = 0; j < cols; ++j) {
      uint8_t value = matrix[i][j];
      if (value == max_rows[i] && value == min_cols[j]) {
        ++s->count;
      }
    }
  }
  s->points = malloc(sizeof(saddle_point_t) * s->count);
  int index = 0;
  for (int i = 0; i < rows; ++i) {
    for (int j = 0; j < cols; ++j) {
      uint8_t value = matrix[i][j];
      if (value == max_rows[i] && value == min_cols[j]) {
        s->points[index++] = (saddle_point_t){.row = i + 1, .column = j + 1};
      }
    }
  }
  free(max_rows);
  free(min_cols);
  return s;
}

void free_saddle_points(saddle_points_t *s) {
  if (s == NULL) {
  }
  if (s->points != NULL) {
    free(s->points);
  }
  free(s);
}
