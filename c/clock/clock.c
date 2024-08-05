#include "clock.h"
#include <math.h>
#include <stdio.h>
#include <string.h>

static const int minutes_an_hour = 60;
static const int minutes_a_day = 24 * minutes_an_hour;

int clock_to_hours(const clock_t clock);
int clock_to_minutes(const clock_t clock);
int normalize_time(const int hour, const int minute);
void write_normalized_time_to_clock(clock_t *clock, const int t);
clock_t clock_from_normalized_time(const int t);

int clock_to_hours(const clock_t clock) {
  return (clock.text[0] - '0') * 10 + clock.text[1] - '0';
}

int clock_to_minutes(const clock_t clock) {
  return (clock.text[3] - '0') * 10 + clock.text[4] - '0';
}

int normalize_time(const int hour, const int minute) {
  int t = (hour * minutes_an_hour + minute) % minutes_a_day;
  if (t < 0) {
    const int factor = 1 + ceil((double)t / minutes_a_day);
    t += factor * minutes_a_day;
  }
  return t;
}

clock_t clock_from_normalized_time(const int t) {
  clock_t c = {0};
  write_normalized_time_to_clock(&c, t);
  return c;
}

void write_normalized_time_to_clock(clock_t *clock, const int t) {
  const unsigned int h = t / 60;
  const unsigned int m = t % 60;
  snprintf(clock->text, MAX_STR_LEN, "%02d:%02d", h, m);
}

clock_t clock_create(const int hour, const int minute) {
  const int t = normalize_time(hour, minute);
  return clock_from_normalized_time(t);
}

clock_t clock_add(const clock_t clock, const int minute_add) {
  const int h = clock_to_hours(clock);
  const int m = clock_to_minutes(clock);
  const int t = normalize_time(h, m + minute_add);
  return clock_from_normalized_time(t);
}

clock_t clock_subtract(const clock_t clock, const int minute_subtract) {
  const int h = clock_to_hours(clock);
  const int m = clock_to_minutes(clock);
  const int t = normalize_time(h, m - minute_subtract);
  return clock_from_normalized_time(t);
}

bool clock_is_equal(const clock_t a, const clock_t b) {
  return strncmp(a.text, b.text, MAX_STR_LEN) == 0;
}
