#include "isogram.h"
#include <ctype.h>
#include <stddef.h>

bool is_isogram(const char phrase[]) {
  if (phrase == NULL) {
    return false;
  }
  bool set[26] = {0};
  for (int i = 0; phrase[i] != '\0'; ++i) {
    char c = phrase[i];
    int offset = isupper(c) ? 'A' : islower(c) ? 'a' : -1;
    if (offset == -1) {
      continue;
    }
    const int index = c - offset;
    if (set[index]) {
      return false;
    }
    set[index] = true;
  }
  return true;
}
