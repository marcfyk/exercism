#include "luhn.h"
#include <stdbool.h>
#include <stddef.h>
#include <string.h>

bool luhn(const char *num) {
  if (num == NULL) {
    return false;
  }
  const int size = strlen(num);
  int sum = 0;
  int digits = 0;
  bool is_even = false;
  for (int i = size - 1; i >= 0; --i) {
    const char c = num[i];
    if (c < '0' || '9' < c) {
      if (c == ' ') {
        continue;
      }
      return false;
    }
    ++digits;
    int add = c - '0';
    if (is_even) {
      add *= 2;
      if (add > 9) {
        add -= 9;
      }
    }
    sum += add;
    is_even = !is_even;
  }
  return digits > 1 && sum % 10 == 0;
}
