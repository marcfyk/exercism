#include "pangram.h"
#include <stddef.h>

bool is_pangram(const char *sentence) {
  if (sentence == NULL) {
    return false;
  }
  bool set[26] = {0};
  for (int i = 0; sentence[i] != '\0'; ++i) {
    const char c = sentence[i];
    if ('A' <= c && c <= 'Z') {
      set[c - 'A'] = true;
    } else if ('a' <= c && c <= 'z') {
      set[c - 'a'] = true;
    }
  }
  for (int i = 0; i < 26; ++i) {
    if (!set[i]) {
      return false;
    }
  }
  return true;
}
