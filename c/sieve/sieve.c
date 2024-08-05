#include "sieve.h"
#include <stdbool.h>
#include <stdlib.h>

uint32_t sieve(const uint32_t limit, uint32_t *primes,
               const size_t max_primes) {
  size_t size = limit - 1;
  bool *s = calloc(sizeof(bool), size);
  uint32_t prime_count = 0;
  for (uint32_t i = 0; i < size; ++i) {
    if (s[i]) {
      continue;
    }
    if (prime_count == max_primes) {
      break;
    }
    uint32_t prime = i + 2;
    primes[prime_count++] = prime;
    uint32_t multiple = prime + prime;
    while (multiple <= limit) {
      s[multiple - 2] = true;
      multiple += prime;
    }
  }
  free(s);
  return prime_count;
}
