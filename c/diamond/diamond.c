#include "diamond.h"
#include <stdlib.h>
#include <string.h>

char **make_diamond(const char letter) {
  int size = 2 * (letter - 'A') + 1;
  char **result = malloc(sizeof(char *) * size);
  char l = 'A';
  for (int i = 0; i <= letter - 'A'; ++i) {
    result[i] = malloc(sizeof(char) * size + 1);
    memset(result[i], ' ', size + 1);
    result[i][size] = '\0';
    result[i][size / 2 + i] = l;
    result[i][size / 2 - i] = l;
    ++l;
  }
  l -= 2;
  for (int i = letter - 'A' + 1; i < size; ++i) {
    result[i] = malloc(sizeof(char) * size + 1);
    memset(result[i], ' ', size + 1);
    result[i][size] = '\0';
    int offset = i - (letter - 'A' + 1) + 1;
    result[i][offset] = l;
    result[i][size - offset - 1] = l;
    --l;
  }
  return result;
}

void free_diamond(char **diamond) {
  if (diamond == NULL) {
    return;
  }
  int size = strlen(*diamond);
  for (int i = 0; i < size; ++i) {
    free(diamond[i]);
  }
  free(diamond);
}
