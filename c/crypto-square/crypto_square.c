#include "crypto_square.h"
#include <ctype.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

char *ciphertext(const char *input) {
  const int length = strlen(input);
  int size = 0;
  for (int i = 0; i < length; ++i) {
    if (!isalnum(input[i])) {
      continue;
    }
    ++size;
  }
  int rows = round(sqrt(size));
  int cols = rows * rows < size ? rows + 1 : rows;
  int elements = rows * cols;
  char *buffer = malloc(elements);
  int write_index = 0;
  for (int i = 0; i < length; ++i) {
    if (!isalnum(input[i])) {
      continue;
    }
    buffer[write_index++] = tolower(input[i]);
  }
  while (write_index < elements) {
    buffer[write_index++] = ' ';
  }
  int cipher_size = elements + cols - 1 >= 0 ? elements + cols - 1 : 0;
  char *transposed = malloc(cipher_size + 1);
  write_index = 0;
  for (int i = 0; i < cols; ++i) {
    for (int j = 0; j < rows; ++j) {
      transposed[write_index++] = buffer[j * cols + i];
    }
    if (i != cols - 1) {
      transposed[write_index++] = ' ';
    }
  }
  transposed[cipher_size] = '\0';
  free(buffer);
  return transposed;
}
