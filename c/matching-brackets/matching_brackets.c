#include "matching_brackets.h"
#include <stdlib.h>
#include <string.h>

static char match_closing_bracket(char c) {
  switch (c) {
  case ')':
    return '(';
  case ']':
    return '[';
  case '}':
    return '{';
  default:
    return 0;
  }
}

bool is_paired(const char *input) {
  int size = strlen(input);
  char *stack = malloc(sizeof(char) * size + 1);
  int stack_size = 0;
  for (int i = 0; i < size; ++i) {
    switch (input[i]) {
    case '(':
    case '[':
    case '{':
      stack[stack_size++] = input[i];
      break;
    case ')':
    case ']':
    case '}':
      if (stack_size <= 0) {
        free(stack);
        return false;
      }
      if (stack[stack_size - 1] != match_closing_bracket(input[i])) {
        free(stack);
        return false;
      }
      --stack_size;
      break;
    default:
      continue;
    }
  }
  free(stack);
  return stack_size == 0;
}
