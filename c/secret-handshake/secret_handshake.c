#include "secret_handshake.h"
#include <math.h>
#include <stdlib.h>

typedef enum {
  Wink = 1,
  DoubleBlink = 2,
  CloseYourEyes = 4,
  Jump = 8,
  Reverse = 16,
} command_t;

const char **commands(size_t number) {
  int n = log2(number);
  char **code = calloc(n >= 0 ? n + 1 : 1, sizeof(char *));
  int index = 0;
  for (int i = 0; i < n + 1; ++i) {
    command_t c = pow(2, i);
    if ((number & c) == 0) {
      continue;
    }
    switch (c) {
    case Wink:
      code[index++] = "wink";
      break;
    case DoubleBlink:
      code[index++] = "double blink";
      break;
    case CloseYourEyes:
      code[index++] = "close your eyes";
      break;
    case Jump:
      code[index++] = "jump";
      break;
    case Reverse:
      for (int i = 0; i < index / 2; ++i) {
        char *tmp = code[index - i - 1];
        code[index - i - 1] = code[i];
        code[i] = tmp;
      }
    }
  }
  return (const char **)code;
}
