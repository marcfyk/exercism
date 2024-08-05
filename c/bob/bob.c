#include "bob.h"
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

static bool is_whitespace(char c) {
  switch (c) {
  case ' ':
  case '\n':
  case '\r':
  case '\t':
    return true;
  default:
    return false;
  }
}

char *hey_bob(char *greeting) {
  if (greeting == NULL) {
    return "Fine. Be that way!";
  }
  int index = 0;
  bool is_empty = true;
  while (greeting[index] != '\0' && !isalpha(greeting[index])) {
    is_empty = is_empty && is_whitespace(greeting[index]);
    ++index;
  }

  bool all_upper = isupper(greeting[index]);
  while (greeting[index] != '\0') {
    is_empty = is_empty && is_whitespace(greeting[index]);
    if (islower(greeting[index])) {
      all_upper = false;
    }
    ++index;
  }
  --index;
  while (index > 0 && is_whitespace(greeting[index])) {
    --index;
  }
  bool is_question = index >= 0 && greeting[index] == '?';
  return is_empty                   ? "Fine. Be that way!"
         : is_question && all_upper ? "Calm down, I know what I'm doing!"
         : is_question              ? "Sure."
         : all_upper                ? "Whoa, chill out!"
                                    : "Whatever.";
}
