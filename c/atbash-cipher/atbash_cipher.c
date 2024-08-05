#include "atbash_cipher.h"
#include <ctype.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

static bool is_punctuation(char c) {
  switch (c) {
  case ' ':
  case '.':
  case ',':
    return true;
  default:
    return false;
  }
}

static char hash(char c) {
  int plaintext_index = tolower(c) - 'a';
  int cipher_index = 25 - plaintext_index;
  return cipher_index + 'a';
}

char *atbash_encode(const char *input) {
  int input_size = strlen(input);
  int spaces = (input_size / 5);
  char *encoded = malloc(input_size + spaces + 1);
  int output_size = 0;
  int chunk_index = 0;
  for (int i = 0; i < input_size; ++i) {
    if (is_punctuation(input[i])) {
      continue;
    }
    if (chunk_index == 5) {
      chunk_index = 0;
      encoded[output_size++] = ' ';
    }
    encoded[output_size++] = isalpha(input[i]) ? hash(input[i]) : input[i];
    ++chunk_index;
  }
  encoded[output_size] = '\0';
  return encoded;
}

char *atbash_decode(const char *input) {
  int output_size = 0;
  for (int i = 0; input[i] != '\0'; ++i) {
    if (!is_punctuation(input[i])) {
      ++output_size;
    }
  }
  char *decoded = malloc(output_size + 1);
  int write_index = 0;
  for (int i = 0; input[i] != '\0'; ++i) {
    if (!is_punctuation(input[i])) {
      decoded[write_index++] = isalpha(input[i]) ? hash(input[i]) : input[i];
    }
  }
  decoded[output_size] = '\0';
  return decoded;
}
