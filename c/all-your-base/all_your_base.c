#include "all_your_base.h"

size_t rebase(int8_t *digits, const int16_t input_base,
              const int16_t output_base, const size_t input_length) {
  if (input_length == 0) {
    return 0;
  }
  if (input_base < 2 || output_base < 2) {
    return 0;
  }
  size_t dec = 0;
  for (size_t i = 0; i < input_length; ++i) {
    if (digits[i] < 0 || digits[i] >= input_base) {
      return 0;
    }
    dec = dec * input_base + digits[i];
  }
  size_t size = 0;
  do {
    digits[size++] = dec % output_base;
    dec /= output_base;
  } while (dec > 0);
  for (size_t i = 0; i < size / 2; ++i) {
    digits[i] ^= digits[size - i - 1];
    digits[size - i - 1] ^= digits[i];
    digits[i] ^= digits[size - i - 1];
  }
  return size;
}
