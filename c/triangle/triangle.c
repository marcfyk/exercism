#include "triangle.h"

bool is_valid(const triangle_t sides);

bool is_valid(const triangle_t sides) {
  return sides.a > 0 && sides.b > 0 && sides.c > 0 &&
         sides.a + sides.b >= sides.c && sides.b + sides.c >= sides.a &&
         sides.a + sides.c >= sides.b;
}

bool is_equilateral(const triangle_t sides) {

  return is_valid(sides) && sides.a == sides.b && sides.b == sides.c;
}

bool is_isosceles(const triangle_t sides) {
  return is_valid(sides) &&
         (sides.a == sides.b || sides.a == sides.c || sides.b == sides.c);
}

bool is_scalene(const triangle_t sides) {
  return is_valid(sides) && sides.a != sides.b && sides.b != sides.c &&
         sides.a != sides.c;
}
