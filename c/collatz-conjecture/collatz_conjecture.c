#include "collatz_conjecture.h"
#include <stdbool.h>

int steps(const int start) {
  if (start <= 0) {
    return ERROR_VALUE;
  }
  int n = start;
  int steps = 0;
  while (true) {
    if (n == 1) {
      break;
    }
    if (n % 2 == 0) {
      n /= 2;
    } else {
      n = 3 * n + 1;
    }
    ++steps;
  }
  return steps;
}
