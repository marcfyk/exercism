#include "gigasecond.h"

const time_t GIGASECOND = 1000000000;

void gigasecond(const time_t input, char *output, const size_t size) {
  const time_t shifted = input + GIGASECOND;
  struct tm *t = gmtime(&shifted);
  strftime(output, size, "%Y-%m-%d %H:%M:%S", t);
}
