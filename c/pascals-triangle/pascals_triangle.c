#include "pascals_triangle.h"

#include <stdlib.h>

void free_triangle(uint8_t **triangle, size_t rows) {
  if (triangle == NULL) {
    return;
  }
  for (size_t i = 0; i < rows; ++i) {
    if (triangle[i] != NULL) {
      free(triangle[i]);
    }
  }
  free(triangle);
}

uint8_t **create_triangle(size_t rows) {
  uint8_t **triangle;
  if (rows == 0) {
    triangle = malloc(sizeof(uint8_t *));
    triangle[0] = calloc(1, sizeof(uint8_t));
    return triangle;
  }
  triangle = malloc(sizeof(uint8_t *) * rows);
  triangle[0] = calloc(rows, sizeof(uint8_t) * rows);
  triangle[0][0] = 1;
  for (size_t i = 1; i < rows; ++i) {
    triangle[i] = calloc(rows, sizeof(uint8_t) * rows);
    triangle[i][0] = 1;
    for (size_t j = 1; j < i + 2; ++j) {
      triangle[i][j] = triangle[i - 1][j] + triangle[i - 1][j - 1];
    }
  }
  return triangle;
}
