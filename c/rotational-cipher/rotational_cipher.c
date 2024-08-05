#include "rotational_cipher.h"

#include <stdlib.h>
#include <string.h>

char *rotate(const char *text, int shift_key) {
  if (text == NULL) {
    return NULL;
  }
  const unsigned long size = strlen(text);
  char *cipher = malloc(sizeof(char) * size + 1);
  for (int i = 0; text[i] != '\0'; ++i) {
    int offset;
    if ('A' <= text[i] && text[i] <= 'Z') {
      offset = 'A';
    } else if ('a' <= text[i] && text[i] <= 'z') {
      offset = 'a';
    } else {
      cipher[i] = text[i];
      continue;
    }
    const int index = text[i] - offset;
    const int shifted_index = (index + shift_key) % 26;
    cipher[i] = shifted_index + offset;
  }
  cipher[size] = '\0';
  return cipher;
}
