#include "armstrong_numbers.h"
#include <stdint.h>

int digits(int n);
int armstrong_sum(int n);

int digits(int n) {
  int count = 0;
  do {
    n /= 10;
    ++count;
  } while (n != 0);
  return count;
}

int armstrong_sum(int n) {
  int sum = 0;
  const int exponent = digits(n);
  do {
    const uint8_t digit = n % 10;
    int s = digit;
    for (int i = 1; i < exponent; ++i) {
      s *= digit;
    }
    sum += s;
    n /= 10;
  } while (n != 0);
  return sum;
}

bool is_armstrong_number(const int candidate) {
  return armstrong_sum(candidate) == candidate;
}
