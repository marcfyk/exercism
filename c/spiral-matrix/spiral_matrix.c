#include "spiral_matrix.h"
#include <stdlib.h>

typedef enum {
  RIGHT,
  DOWN,
  LEFT,
  UP,
} direction_t;

spiral_matrix_t *spiral_matrix_create(const int n) {
  spiral_matrix_t *m = malloc(sizeof(spiral_matrix_t));
  m->size = n;
  m->matrix = n == 0 ? NULL : malloc(sizeof(int *) * n);
  for (int i = 0; i < n; ++i) {
    m->matrix[i] = malloc(sizeof(int) * n);
  }
  direction_t d = RIGHT;
  int left = 0;
  int right = n - 1;
  int top = 0;
  int bot = n - 1;
  int value = 1;
  while (left <= right && top <= bot) {
    switch (d) {
    case RIGHT:
      for (int i = left; i <= right; ++i) {
        m->matrix[top][i] = value++;
      }
      ++top;
      d = DOWN;
      break;
    case DOWN:
      for (int i = top; i <= bot; ++i) {
        m->matrix[i][right] = value++;
      }
      --right;
      d = LEFT;
      break;
    case LEFT:
      for (int i = right; i >= left; --i) {
        m->matrix[bot][i] = value++;
      }
      --bot;
      d = UP;
      break;
    case UP:
      for (int i = bot; i >= top; --i) {
        m->matrix[i][left] = value++;
      }
      ++left;
      d = RIGHT;
      break;
    }
  }
  return m;
}

void spiral_matrix_destroy(spiral_matrix_t *m) {
  if (m == NULL) {
    return;
  }
  if (m != NULL) {
    for (int i = 0; i < m->size; ++i) {
      free(m->matrix[i]);
    }
    free(m->matrix);
  }
  free(m);
}
