#include "hamming.h"

int compute(const char *lhs, const char *rhs) {
  if (!lhs || !rhs) {
    return -1;
  }
  int count = 0;
  int i;
  for (i = 0; lhs[i] != '\0' && rhs[i] != '\0'; ++i) {
    if (lhs[i] != rhs[i]) {
      ++count;
    }
  }
  return lhs[i] != '\0' || rhs[i] != '\0' ? -1 : count;
}
