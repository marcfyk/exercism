#include "sum_of_multiples.h"
#include <stdbool.h>

unsigned int sum(const unsigned int *factors, const size_t number_of_factors,
                 const unsigned int limit) {
  if (number_of_factors <= 0 || limit <= 1 || factors == NULL) {
    return 0;
  }
  bool multiples[limit];
  for (unsigned int i = 1; i < limit; ++i) {
    multiples[i] = false;
    for (size_t j = 0; j < number_of_factors; ++j) {
      if (factors[j] == 0) {
        continue;
      }
      if (i % factors[j] == 0) {
        multiples[i] = true;
      }
    }
  }
  unsigned int sum = 0;
  for (unsigned int i = 1; i < limit; ++i) {
    if (multiples[i]) {
      sum += i;
    }
  }
  return sum;
}
