#include "acronym.h"

#include <ctype.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int phrase_index;
  int phrase_size;
  const char *phrase;
  int acronym_index;
  char *acronym;
} parser_t;

static bool is_alpha(char c) {
  return ('A' <= c && c <= 'Z') || ('a' <= c && c <= 'z');
}

static parser_t new_parser(const char *phrase) {
  int size = strlen(phrase);
  return (parser_t){
      .phrase_index = 0,
      .phrase_size = size,
      .phrase = phrase,
      .acronym_index = 0,
      .acronym = malloc(sizeof(char) * size + 1),
  };
}

static bool is_done(parser_t *p) { return p->phrase_index >= p->phrase_size; }

static void read_char(parser_t *p, int n) { p->phrase_index += n; }

static char peek_char(parser_t *p, int n) {
  int cursor = p->phrase_index + n;
  if (cursor < 0 || cursor >= p->phrase_size) {
    return 0;
  }
  return p->phrase[cursor];
}

static char curr_char(parser_t *p) { return peek_char(p, 0); }

static void consume_delimiter(parser_t *p) {
  bool in_delimiter = true;
  while (in_delimiter) {
    switch (curr_char(p)) {
    case ' ':
    case '-':
    case ',':
    case '_':
      read_char(p, 1);
      break;
    default:
      in_delimiter = false;
    }
  }
}

static char read_word(parser_t *p) {
  char acronym_letter = curr_char(p);
  if (!is_alpha(acronym_letter)) {
    return 0;
  }
  char d = curr_char(p);
  while (is_alpha(d) || d == '\'') {
    read_char(p, 1);
    d = curr_char(p);
  }
  return acronym_letter;
}

static bool write_char(parser_t *p, char c) {
  if (p->acronym_index >= p->phrase_size) {
    return false;
  }
  p->acronym[p->acronym_index++] = toupper(c);
  return true;
}

char *abbreviate(const char *phrase) {
  if (phrase == NULL || strcmp(phrase, "") == 0) {
    return NULL;
  }
  parser_t p = new_parser(phrase);
  while (!is_done(&p)) {
    consume_delimiter(&p);
    char c = read_word(&p);
    if (!write_char(&p, c)) {
      return NULL;
    }
  }
  p.acronym[p.acronym_index] = '\0';
  return p.acronym;
}
