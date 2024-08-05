#include "series.h"
#include <stdlib.h>
#include <string.h>

slices_t slices(char *input_text, unsigned int substring_length) {
  if (substring_length == 0) {
    char *s[] = {""};
    return (slices_t){
        .substring_count = 0,
        .substring = s,
    };
  }
  int size = strlen(input_text);
  int windows = size - substring_length + 1;
  if (windows <= 0 || substring_length == 0) {
    char *s[] = {""};
    return (slices_t){
        .substring_count = 0,
        .substring = s,
    };
  }
  slices_t s = {
      .substring_count = windows,
      .substring = malloc(sizeof(char *) * windows),
  };
  for (size_t i = 0; i < size - substring_length + 1; ++i) {
    s.substring[i] = malloc(sizeof(char) * (substring_length) + 1);
    strncpy(s.substring[i], &input_text[i], substring_length);
    s.substring[i][substring_length] = '\0';
  }
  return s;
}
