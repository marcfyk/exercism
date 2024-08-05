#include "word_count.h"

#include <ctype.h>
#include <stdbool.h>
#include <string.h>
#include <strings.h>

int count_words(const char *sentence, word_count_word_t *words) {
  size_t read_index = 0;
  size_t write_index = 0;
  while (sentence[read_index] != '\0') {
    while (sentence[read_index] != '\0' && !isalpha(sentence[read_index]) &&
           !isdigit(sentence[read_index])) {
      ++read_index;
    }
    int start_index = read_index;
    while (sentence[read_index] != '\0') {
      if (isalpha(sentence[read_index]) || isdigit(sentence[read_index])) {
        ++read_index;
      } else if (sentence[read_index] == '\'') {
        if (isalpha(sentence[read_index + 1]) ||
            isdigit(sentence[read_index + 1])) {
          ++read_index;
        } else {
          break;
        }
      } else {
        break;
      }
    }
    size_t size = read_index - start_index;
    if (size == 0) {
      break;
    }
    word_count_word_t *w = &words[write_index];
    for (size_t i = 0; i < write_index; ++i) {
      if (words[i].text[size] == '\0' &&
          strncasecmp(words[i].text, &sentence[start_index], size) == 0) {
        w = &words[i];
        break;
      }
    }
    ++w->count;
    if (w == &words[write_index]) {
      for (size_t i = 0; i < size; ++i) {
        words[write_index].text[i] = tolower(sentence[start_index + i]);
      }
      words[write_index].text[size] = '\0';
      ++write_index;
    }
  }
  return write_index;
}
