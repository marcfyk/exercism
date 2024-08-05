#include "eliuds_eggs.h"

unsigned int egg_count(unsigned int decimal) {
  int count = 0;
  while (decimal != 0) {
    if (decimal % 2 == 1) {
      ++count;
    }
    decimal /= 2;
  }
  return count;
}
