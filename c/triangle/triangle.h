#ifndef TRIANGLE_H
#define TRIANGLE_H

#include <stdbool.h>

typedef struct {
  double a;
  double b;
  double c;
} triangle_t;

bool is_equilateral(const triangle_t sides);
bool is_isosceles(const triangle_t sides);
bool is_scalene(const triangle_t sides);

#endif
