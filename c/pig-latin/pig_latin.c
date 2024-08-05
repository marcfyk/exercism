#include "pig_latin.h"
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

static bool is_vowel(const char *phrase, int index) {
  switch (phrase[index]) {
  case 'a':
  case 'e':
  case 'i':
  case 'o':
  case 'u':
    return true;
  case 'y':
    if (index == 0) {
      return false;
    }
    switch (phrase[index - 1]) {
    case 'a':
    case 'e':
    case 'i':
    case 'o':
    case 'u':
      return false;
    default:
      return true;
    }
  default:
    return false;
  }
}

static bool check_rule_one(const char *phrase, int length) {
  if (length == 0) {
    return false;
  }
  if (is_vowel(phrase, 0)) {
    return true;
  }
  if (length < 2) {
    return false;
  }
  switch (phrase[0]) {
  case 'x':
    return phrase[1] == 'r';
  case 'y':
    return phrase[1] == 't';
  case 'a':
    return phrase[1] == 'y';
  default:
    return false;
  }
}

static int check_rule_two(const char *phrase, int length) {
  if (length == 0 || is_vowel(phrase, 0)) {
    return -1;
  }
  int index = 0;
  while (index < length && !is_vowel(phrase, index)) {
    ++index;
  };
  return index;
}

static int check_rule_three(const char *phrase, int length) {
  int index = 0;
  while (index < length && !is_vowel(phrase, index)) {
    ++index;
  }
  if (index + 1 >= length) {
    return -1;
  }
  if (index > 0 && phrase[index - 1] == 'q' && phrase[index] == 'u') {
    return index + 1;
  }
  return phrase[index] == 'q' && phrase[index + 1] == 'u' ? index + 2 : -1;
}

static int check_rule_four(const char *phrase, int length) {
  if (length == 0) {
    return -1;
  }
  int index = 0;
  while (!is_vowel(phrase, index)) {
    ++index;
  }
  if (index == 0 || index >= length) {
    return -1;
  }
  return phrase[index] == 'y' ? index - 1 : -1;
}

static void translate_word(const char *phrase, int *read_index,
                           int *write_index, char *translated) {
  int length = 0;
  for (int i = *read_index; phrase[i] != '\0' && phrase[i] != ' '; ++i) {
    ++length;
  }
  bool is_rule_one = check_rule_one(&phrase[*read_index], length);
  int rule_two_index = check_rule_two(&phrase[*read_index], length);
  int rule_three_index = check_rule_three(&phrase[*read_index], length);
  int rule_four_index = check_rule_four(&phrase[*read_index], length);

  if (!is_rule_one && rule_two_index == -1 && rule_three_index == -1 &&
      rule_four_index == -1) {
    strncpy(translated, &phrase[*read_index], length);
    *read_index += length;
    *write_index += length;
    return;
  }
  translated[*write_index + length] = 'a';
  translated[*write_index + length + 1] = 'y';

  int pivot_index = is_rule_one              ? -1
                    : rule_three_index != -1 ? rule_three_index
                    : rule_two_index != -1   ? rule_two_index
                    : rule_four_index != -1  ? rule_four_index
                                             : -1;
  if (pivot_index != -1) {
    int suffix_length = length - pivot_index;
    strncpy(&translated[*write_index], &phrase[*read_index + pivot_index],
            suffix_length);
    strncpy(&translated[*write_index + suffix_length], &phrase[*read_index],
            pivot_index);
  } else {
    strncpy(&translated[*write_index], &phrase[*read_index], length);
  }
  *read_index += length;
  *write_index += length + 2;
}

char *translate(const char *phrase) {
  int length = strlen(phrase);
  char *buffer = malloc(2 * length + 1);
  int read_index = 0;
  int write_index = 0;
  while (read_index < length) {
    translate_word(phrase, &read_index, &write_index, buffer);
    while (phrase[read_index] == ' ') {
      buffer[write_index++] = ' ';
      ++read_index;
    }
  }
  buffer[write_index] = '\0';
  return buffer;
}
