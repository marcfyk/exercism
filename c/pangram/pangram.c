#include "pangram.h"
#include <ctype.h>
#include <stddef.h>

bool is_pangram(const char *sentence) {
  if (sentence == NULL) {
    return false;
  }
  bool set[26] = {0};
  for (int i = 0; sentence[i] != '\0'; ++i) {
    const char c = sentence[i];
    int offset = isupper(c) ? 'A' : islower(c) ? 'a' : -1;
    if (offset == -1) {
      continue;
    }
    set[c - offset] = true;
  }
  for (int i = 0; i < 26; ++i) {
    if (!set[i]) {
      return false;
    }
  }
  return true;
}
