#include "grains.h"
#include <stdint.h>

uint64_t square(const uint8_t index) {
  if (index < 1) {
    return 0;
  }
  uint64_t grains = 1;
  for (int i = 1; i < index; ++i) {
    grains <<= 1;
  }
  return grains;
}

uint64_t total() {
  uint64_t r = 2;
  for (int i = 0; i < 64; ++i) {
    r *= r;
  }
  return r - 1;
}
