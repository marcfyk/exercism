#include "perfect_numbers.h"
#include <math.h>

kind classify_number(const int number) {
  if (number <= 0) {
    return ERROR;
  }
  int sum = -number;
  const int limit = (int)floor(sqrt(number));
  for (int i = 1; i <= limit; ++i) {
    if (number % i == 0) {
      const int d = number / i;
      sum += d != i ? d + i : i;
    }
  }
  if (sum < number) {
    return DEFICIENT_NUMBER;
  } else if (sum > number) {
    return ABUNDANT_NUMBER;
  } else {
    return PERFECT_NUMBER;
  }
}
