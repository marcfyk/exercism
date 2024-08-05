#include "rail_fence_cipher.h"
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

char *encode(char *text, size_t rails) {
  size_t length = strlen(text);
  char *encoded = malloc(length + 1);
  size_t index = 0;
  for (size_t i = 0; i < rails; ++i) {
    size_t offset1 = 2 * (rails - 1 - i > 0 ? rails - 1 - i : rails - 1);
    size_t offset2 = 2 * i;
    offset1 = offset1 == 0 ? offset2 : offset1;
    offset2 = offset2 == 0 ? offset1 : offset2;
    bool use_offset1 = false;
    for (size_t j = i; j < length; j += (use_offset1 ? offset1 : offset2)) {
      encoded[index++] = text[j];
      use_offset1 = !use_offset1;
    }
  }
  encoded[length] = '\0';
  return encoded;
}

char *decode(char *ciphertext, size_t rails) {
  size_t length = strlen(ciphertext);
  char *decoded = malloc(length + 1);
  size_t index = 0;
  for (size_t i = 0; i < rails; ++i) {
    size_t offset1 = 2 * (rails - 1 - i > 0 ? rails - 1 - i : rails - 1);
    size_t offset2 = 2 * i;
    offset1 = offset1 == 0 ? offset2 : offset1;
    offset2 = offset2 == 0 ? offset1 : offset2;
    bool use_offset1 = false;
    for (size_t j = i; j < length; j += (use_offset1 ? offset1 : offset2)) {
      decoded[j] = ciphertext[index++];
      use_offset1 = !use_offset1;
    }
  }
  decoded[length] = '\0';
  return decoded;
}
