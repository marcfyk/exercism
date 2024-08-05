#include "nth_prime.h"
#include <stdbool.h>

uint32_t nth(const uint32_t n) {
  if (n == 0) {
    return 0;
  }
  uint32_t count = 0;
  uint32_t i = 2;
  while (count < n) {
    bool is_prime = true;
    for (uint32_t d = 2; d < i; ++d) {
      if (i % d == 0) {
        is_prime = false;
        break;
      }
    }
    if (is_prime) {
      ++count;
    }
    ++i;
  }
  return i - 1;
}
