#include "anagram.h"
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

static enum anagram_status is_anagram(const char *w1, const char *w2) {
  int s1 = strlen(w1);
  int s2 = strlen(w2);
  if (s1 != s2) {
    return NOT_ANAGRAM;
  }
  int histogram[26] = {0};
  bool is_same_word = true;
  for (int i = 0; i < s1; ++i) {
    char lc1 = tolower(w1[i]);
    char lc2 = tolower(w2[i]);
    is_same_word = is_same_word && lc1 == lc2;
    ++histogram[lc1 - 'a'];
    --histogram[lc2 - 'a'];
  }
  if (is_same_word) {
    return NOT_ANAGRAM;
  }
  for (int i = 0; i < 26; ++i) {
    if (histogram[i] != 0) {
      return NOT_ANAGRAM;
    }
  }
  return IS_ANAGRAM;
}

void find_anagrams(const char *subject, struct candidates *candidates) {
  for (size_t i = 0; i < candidates->count; ++i) {
    candidates->candidate[i].is_anagram =
        is_anagram(subject, candidates->candidate[i].word);
  }
}
