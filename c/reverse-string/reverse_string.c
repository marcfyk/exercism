#include "reverse_string.h"
#include <stdlib.h>
#include <string.h>

char *reverse(const char *value) {
  if (value == NULL) {
    return NULL;
  }
  const int size = strlen(value);
  char *reversed = malloc(sizeof(char) * size + 1);
  int index = 0;
  for (int i = size - 1; i >= 0; --i) {
    reversed[index++] = value[i];
  }
  reversed[index] = '\0';
  return reversed;
}
