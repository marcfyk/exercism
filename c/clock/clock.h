#ifndef CLOCK_H
#define CLOCK_H

#include <stdbool.h>

#define MAX_STR_LEN sizeof("##:##")

typedef struct {
  char text[MAX_STR_LEN];
} clock_t;

clock_t clock_create(const int hour, const int minute);
clock_t clock_add(const clock_t clock, const int minute_add);
clock_t clock_subtract(const clock_t clock, const int minute_subtract);
bool clock_is_equal(const clock_t a, const clock_t b);

#endif
