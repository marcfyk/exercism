#include "largest_series_product.h"
#include <ctype.h>
#include <string.h>

static int64_t next_span(char *digits, size_t len, size_t span, size_t *index) {
  size_t start_index = *index;
  int64_t product = 1;
  size_t window = 0;
  while (*index < len && window < span) {
    char c = digits[*index];
    if (!isdigit(c)) {
      return -1;
    }
    int64_t d = digits[*index] - '0';
    if (d == 0) {
      ++*index;
      product = 1;
      window = 0;
      continue;
    }
    product *= d;
    ++window;
    ++*index;
  }
  *index = start_index + 1;
  if (window < span) {
    return 0;
  }
  return product;
}

int64_t largest_series_product(char *digits, size_t span) {
  if (span <= 0) {
    return -1;
  }
  size_t len = strlen(digits);
  if (span > len) {
    return -1;
  }
  size_t index = 0;
  int64_t result = next_span(digits, len, span, &index);
  while (index < len) {
    int64_t r = next_span(digits, len, span, &index);
    if (r == -1) {
      return -1;
    }
    result = r > result ? r : result;
  }
  return result;
}
