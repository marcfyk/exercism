#include "run_length_encoding.h"
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

char *encode(const char *text) {
  if (text == NULL || strcmp(text, "") == 0) {
    char *encoded = malloc(1);
    encoded[0] = '\0';
    return encoded;
  }
  int text_length = strlen(text);
  char *encoded = malloc(text_length + 1);
  int read_index = 0;
  int write_index = 0;
  while (read_index < text_length) {
    char c = text[read_index];
    int count = 1;
    while (read_index < text_length - 1 && text[read_index + 1] == c) {
      ++count;
      ++read_index;
    }
    ++read_index;
    if (count == 1) {
      encoded[write_index++] = c;
    } else {
      int i = write_index;
      while (count > 0) {
        encoded[i++] = (count % 10) + '0';
        count /= 10;
      }
      for (int idx = write_index; idx < write_index + (i - write_index) / 2;
           ++idx) {
        encoded[idx] ^= encoded[i - 1 - idx + write_index];
        encoded[i - 1 - idx + write_index] ^= encoded[idx];
        encoded[idx] ^= encoded[i - 1 - idx + write_index];
      }
      write_index = i;
      encoded[write_index++] = c;
    }
  }
  encoded[write_index] = '\0';
  return encoded;
}

static int read_number(const char *buffer, int *index) {
  int n = 0;
  while (buffer[*index] != '\0' && isdigit(buffer[*index])) {
    n = n * 10 + (buffer[(*index)++] - '0');
  }
  return n;
}

char *decode(const char *data) {
  if (data == NULL || strcmp(data, "") == 0) {
    char *decoded = malloc(1);
    decoded[0] = '\0';
    return decoded;
  }
  int read_index = 0;
  int size = 0;
  while (data[read_index] != '\0') {
    if (!isdigit(data[read_index])) {
      ++size;
      ++read_index;
      continue;
    }
    size += read_number(data, &read_index);
    ++read_index;
  }
  char *decoded = malloc(size + 1);
  read_index = 0;
  int write_index = 0;
  while (data[read_index] != '\0') {
    if (!isdigit(data[read_index])) {
      decoded[write_index++] = data[read_index++];
      continue;
    }
    int n = read_number(data, &read_index);
    char c = data[read_index++];
    memset(&decoded[write_index], c, n);
    write_index += n;
  }
  decoded[size] = '\0';
  return decoded;
}
