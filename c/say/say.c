#include "say.h"
#include <stdio.h>
#include <stdlib.h>

static const char *repr_digit(int n) {
  switch (n) {
  case 0:
    return "zero";
  case 1:
    return "one";
  case 2:
    return "two";
  case 3:
    return "three";
  case 4:
    return "four";
  case 5:
    return "five";
  case 6:
    return "six";
  case 7:
    return "seven";
  case 8:
    return "eight";
  case 9:
    return "nine";
  default:
    return "";
  }
}

static const char *repr_prefix_20_to_99(int n) {
  switch (n / 10) {
  case 2:
    return "twenty";
  case 3:
    return "thirty";
  case 4:
    return "forty";
  case 5:
    return "fifty";
  case 6:
    return "sixty";
  case 7:
    return "seventy";
  case 8:
    return "eighty";
  case 9:
    return "ninety";
  default:
    return "";
  }
}

static const char *repr_10_to_19(int n) {
  switch (n % 10) {
  case 0:
    return "ten";
  case 1:
    return "eleven";
  case 2:
    return "twelve";
  case 3:
    return "thirteen";
  case 4:
    return "fourteen";
  case 5:
    return "fifteen";
  case 6:
    return "sixteen";
  case 7:
    return "seventeen";
  case 8:
    return "eighteen";
  case 9:
    return "nineteen";
  default:
    return "";
  }
}

static int write_0_to_99(int64_t n, char *buffer, int index) {
  if (n < 0 || n > 99) {
    return -1;
  }
  if (n < 10) {
    return sprintf(&buffer[index], "%s", repr_digit(n));
  } else if (n < 20) {
    return sprintf(&buffer[index], "%s", repr_10_to_19(n));
  } else {
    const char *prefix = repr_prefix_20_to_99(n);
    int d = n % 10;
    return (d == 0) ? sprintf(&buffer[index], "%s", prefix)
                    : sprintf(&buffer[index], "%s-%s", prefix, repr_digit(d));
  }
}

static int write_0_to_999(int64_t n, char *buffer, int index) {
  if (n < 0 || n > 999) {
    return -1;
  }
  if (n < 100) {
    return write_0_to_99(n, buffer, index);
  }
  const char *prefix = repr_digit(n / 100);
  int suffix = n % 100;
  if (suffix == 0) {
    return sprintf(&buffer[index], "%s hundred", prefix);
  } else {
    int prefix_length = sprintf(&buffer[index], "%s hundred ", prefix);
    int suffix_length = write_0_to_99(suffix, buffer, index + prefix_length);
    if (suffix_length == -1) {
      return -1;
    }
    return prefix_length + suffix_length;
  }
}

static int write_thousandths(int64_t *n, char *buffer, int index,
                             int64_t divisor, const char *suffix) {
  int64_t d = *n / divisor;
  *n %= divisor;
  if (d == 0) {
    return 0;
  }
  if (d > 1000) {
    return -1;
  }
  int written = write_0_to_999(d, buffer, index);
  index += written;
  const char *f = *n > 0 ? " %s " : " %s";
  if (divisor > 1) {
    written += sprintf(&buffer[index], f, suffix);
  }
  return written;
}

const int buffer_length =
    sizeof("nine hundred ninety-nine billion nine hundred ninety-nine million "
           "nine hundred ninety-nine thousand nine hundred ninety-nine");

int say(int64_t input, char **ans) {
  if (input < 0 || input > 999999999999) {
    return -1;
  }
  if (input == 0) {
    *ans = malloc(sizeof("zero"));
    sprintf(*ans, "zero");
    return 0;
  }
  *ans = malloc(buffer_length * sizeof(char));
  int index = 0;
  int written;
  written = write_thousandths(&input, *ans, index, 1000000000, "billion");
  if (written == -1) {
    return -1;
  }
  index += written;
  written = write_thousandths(&input, *ans, index, 1000000, "million");
  if (written == -1) {
    return -1;
  }
  index += written;
  written = write_thousandths(&input, *ans, index, 1000, "thousand");
  if (written == -1) {
    return -1;
  }
  index += written;
  written = write_thousandths(&input, *ans, index, 1, "");
  if (written == -1) {
    return -1;
  }
  return 0;
}
