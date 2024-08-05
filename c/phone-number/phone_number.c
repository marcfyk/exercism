#include "phone_number.h"

#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int read_index;
  const char *input;
  const int size;
  int write_index;
  char *phone_number;
} parser_t;

static int phone_number_length = 10;

static parser_t new_parser(const char *input) {
  parser_t p = {
      .read_index = 0,
      .input = input,
      .size = strlen(input),
      .write_index = 0,
      .phone_number = malloc(sizeof(char) * phone_number_length + 1),
  };
  p.phone_number[phone_number_length] = '\0';
  return p;
}

static void read_char(parser_t *p, int n) { p->read_index += n; }

static char peek_char(parser_t *p, int n) {
  int cursor = p->read_index + n;
  if (cursor < 0 || cursor >= p->size) {
    return 0;
  }
  return p->input[cursor];
}

static char curr_char(parser_t *p) { return peek_char(p, 0); }

static bool write_digit(parser_t *p, char d) {
  if (p->write_index < 0 || p->write_index >= phone_number_length) {
    return false;
  }
  p->phone_number[p->write_index++] = d;
  return true;
}

static bool is_digit(char c) { return 0x30 <= c && c <= 0x39; }

static void consume_whitespace(parser_t *p) {
  while (curr_char(p) == ' ') {
    read_char(p, 1);
  }
}

static char *parser_error(parser_t *p) {
  memset(p->phone_number, '0', sizeof(char) * phone_number_length);
  return p->phone_number;
}

static bool parse_international_country_code(parser_t *p) {
  if (curr_char(p) == '+') {
    read_char(p, 1);
  }
  if (curr_char(p) == '1') {
    read_char(p, 1);
  }
  return true;
}

static bool parse_number_plan_area_code(parser_t *p) {
  bool has_brackets = false;
  if (curr_char(p) == '(') {
    has_brackets = true;
    read_char(p, 1);
  }

  char d = curr_char(p);
  if (!is_digit(d) || d == '0' || d == '1') {
    return false;
  }
  if (!write_digit(p, d)) {
    return false;
  };
  read_char(p, 1);
  for (int i = 0; i < 2; ++i) {
    d = curr_char(p);
    if (!is_digit(d)) {
      return false;
    }
    if (!write_digit(p, d)) {
      return false;
    }
    read_char(p, 1);
  }
  if (has_brackets) {
    if (curr_char(p) != ')') {
      return false;
    }
    read_char(p, 1);
  }
  return true;
}

static bool parse_delimiter(parser_t *p) {
  switch (curr_char(p)) {
  case '.':
  case '-':
    read_char(p, 1);
    return true;
  default:
    return false;
  }
}

static bool parse_local_number(parser_t *p) {
  char d = curr_char(p);
  if (!is_digit(d) || d == '0' || d == '1') {
    return false;
  }
  if (!write_digit(p, d)) {
    return false;
  }
  read_char(p, 1);
  for (int i = 0; i < 2; ++i) {
    d = curr_char(p);
    if (!is_digit(d)) {
      return false;
    }
    if (!write_digit(p, d)) {
      return false;
    }
    read_char(p, 1);
  }
  if (!parse_delimiter(p)) {
    consume_whitespace(p);
  }
  for (int i = 0; i < 4; ++i) {
    d = curr_char(p);
    if (!is_digit(d)) {
      return false;
    }
    if (!write_digit(p, d)) {
      return false;
    }
    read_char(p, 1);
  }
  return true;
}

char *phone_number_clean(const char *input) {
  parser_t p = new_parser(input);
  consume_whitespace(&p);
  if (!parse_international_country_code(&p)) {
    return parser_error(&p);
  }
  consume_whitespace(&p);
  if (!parse_number_plan_area_code(&p)) {
    return parser_error(&p);
  }
  if (!parse_delimiter(&p)) {
    consume_whitespace(&p);
  };
  if (!parse_local_number(&p)) {
    return parser_error(&p);
  }
  consume_whitespace(&p);
  return p.write_index != phone_number_length || p.read_index != p.size
             ? parser_error(&p)
             : p.phone_number;
}
