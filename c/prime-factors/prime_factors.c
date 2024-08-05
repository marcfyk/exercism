#include "prime_factors.h"

size_t find_factors(uint64_t n, uint64_t factors[static MAXFACTORS]) {
  size_t index = 0;
  int factor = 2;
  while (n != 1) {
    while (n % factor == 0) {
      factors[index++] = factor;
      n /= factor;
    }
    ++factor;
  }
  return index;
}
