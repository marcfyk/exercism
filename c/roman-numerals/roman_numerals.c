#include "roman_numerals.h"
#include <stdlib.h>

const int max_length = 9;

static void write_digits(int decimal_divisor, unsigned int *number,
                         char roman_high, char roman_mid, char roman_low,
                         char *buffer, int *index) {
  int d = *number / decimal_divisor;
  if (d == 10) {
    buffer[(*index)++] = roman_high;
  } else if (d == 9) {
    buffer[(*index)++] = roman_low;
    buffer[(*index)++] = roman_high;
  } else if (d >= 5) {
    buffer[(*index)++] = roman_mid;
    for (int i = 0; i < d - 5; ++i) {
      buffer[(*index)++] = roman_low;
    }
  } else if (d == 4) {
    buffer[(*index)++] = roman_low;
    buffer[(*index)++] = roman_mid;
  } else {
    for (int i = 0; i < d; ++i) {
      buffer[(*index)++] = roman_low;
    }
  }
  *number %= decimal_divisor;
}

char *to_roman_numeral(unsigned int number) {
  char *buffer = malloc((max_length + 1) * sizeof(char));
  int index = 0;
  write_digits(1000, &number, 0, 0, 'M', buffer, &index);
  write_digits(100, &number, 'M', 'D', 'C', buffer, &index);
  write_digits(10, &number, 'C', 'L', 'X', buffer, &index);
  write_digits(1, &number, 'X', 'V', 'I', buffer, &index);
  buffer[index] = '\0';
  return buffer;
}
