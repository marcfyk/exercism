#include "isogram.h"
#include <stddef.h>

bool is_isogram(const char phrase[]) {
  if (phrase == NULL) {
    return false;
  }
  bool set[26] = {0};
  for (int i = 0; phrase[i] != '\0'; ++i) {
    char c = phrase[i];
    int offset = -1;
    if ('A' <= c && c <= 'Z') {
      offset = 'A';
    } else if ('a' <= c && c <= 'z') {
      offset = 'a';
    }
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
