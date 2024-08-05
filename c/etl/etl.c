#include "etl.h"
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

static int cmp(const void *p1, const void *p2) {
  new_map *n1 = (new_map *)p1;
  new_map *n2 = (new_map *)p2;
  return n1->key - n2->key;
}

int convert(const legacy_map *input, const size_t input_len, new_map **output) {
  int size = 0;
  for (size_t i = 0; i < input_len; ++i) {
    size += strlen(input[i].keys);
  }
  *output = malloc(sizeof(new_map) * size);

  int write_index = 0;
  for (size_t i = 0; i < input_len; ++i) {
    for (size_t j = 0; input[i].keys[j] != '\0'; ++j) {
      (*output)[write_index++] = (new_map){
          .key = tolower(input[i].keys[j]),
          .value = input[i].value,
      };
    }
  }
  qsort(*output, write_index, sizeof(new_map), cmp);
  return write_index;
}
