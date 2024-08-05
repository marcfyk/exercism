#include "wordy.h"
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

const char *prefix = "What is ";
const int prefix_length = sizeof("What is ") - 1;
const char *plus = " plus ";
const int plus_length = sizeof(" plus ") - 1;
const char *minus = " minus ";
const int minus_length = sizeof(" minus ") - 1;
const char *multiply = " multiplied by ";
const int multiply_length = sizeof(" multiplied by ") - 1;
const char *divide = " divided by ";
const int divide_length = sizeof(" divided by ") - 1;

typedef enum token_type_t {
  Number,
  Plus,
  Minus,
  Multiply,
  Divide,
} token_type_t;

typedef struct token_t {
  token_type_t type;
  int number;
} token_t;

static token_t read_token(const char *question, int *read_index) {
  if (strncmp(&question[*read_index], plus, plus_length) == 0) {
    *read_index += plus_length;
    return (token_t){.type = Plus};
  } else if (strncmp(&question[*read_index], minus, minus_length) == 0) {
    *read_index += minus_length;
    return (token_t){.type = Minus};
  } else if (strncmp(&question[*read_index], multiply, multiply_length) == 0) {
    *read_index += multiply_length;
    return (token_t){.type = Multiply};
  } else if (strncmp(&question[*read_index], divide, divide_length) == 0) {
    *read_index += divide_length;
    return (token_t){.type = Divide};
  }
  bool is_negative = false;
  if (question[*read_index] == '-') {
    is_negative = true;
    ++*read_index;
  }
  int start = *read_index;
  while (isdigit(question[*read_index])) {
    ++*read_index;
  }
  int d = 0;
  for (int i = start; i < *read_index; ++i) {
    d = d * 10 + (question[i] - '0');
  }
  return (token_t){
      .type = Number,
      .number = is_negative ? -d : d,
  };
}

bool answer(const char *question, int *result) {
  const int question_length = strlen(question);
  const int prefix_length = strlen(prefix);
  if (strncmp(question, prefix, prefix_length) != 0) {
    return false;
  }
  int read_index = prefix_length;
  token_t t = read_token(question, &read_index);
  if (t.type != Number) {
    return false;
  }
  *result = t.number;
  while (read_index < question_length && question[read_index] != '?') {
    t = read_token(question, &read_index);
    switch (t.type) {
    case Number:
      return false;
    case Plus:
      t = read_token(question, &read_index);
      if (t.type != Number) {
        return false;
      }
      *result += t.number;
      break;
    case Minus:
      t = read_token(question, &read_index);
      if (t.type != Number) {
        return false;
      }
      *result -= t.number;
      break;
    case Multiply:
      t = read_token(question, &read_index);
      if (t.type != Number) {
        return false;
      }
      *result *= t.number;
      break;
    case Divide:
      t = read_token(question, &read_index);
      if (t.type != Number) {
        return false;
      }
      *result /= t.number;
      break;
    }
  }
  return true;
}
