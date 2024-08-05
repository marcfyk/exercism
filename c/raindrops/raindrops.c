#include "raindrops.h"
#include <stdio.h>
#include <string.h>

void convert(char result[], const int drops) {
  if (drops % 3 == 0) {
    strcat(result, "Pling");
  }
  if (drops % 5 == 0) {
    strcat(result, "Plang");
  }
  if (drops % 7 == 0) {
    strcat(result, "Plong");
  }
  if (drops % 3 != 0 && drops % 5 != 0 && drops % 7 != 0) {
    sprintf(result, "%d", drops);
  }
}
