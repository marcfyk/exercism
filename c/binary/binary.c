#include "binary.h"

int convert(const char *input) {
  int n = 0;
  for (int i = 0; input[i] != '\0'; ++i) {
    n *= 2;
    switch (input[i]) {
    case '1':
      ++n;
    case '0':
      continue;
    default:
      return INVALID;
    }
  }
  return n;
}
