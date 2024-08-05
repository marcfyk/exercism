#include "meetup.h"
#include <string.h>
#include <time.h>

static int day_to_tm_wday(const char *day) {
  const char *days[] = {"Sunday",   "Monday", "Tuesday", "Wednesday",
                        "Thursday", "Friday", "Saturday"};
  for (size_t i = 0; i < 7; ++i) {
    if (strcmp(day, days[i]) == 0) {
      return i;
    }
  }
  return -1;
}

static int week_offset_in_tm_mday(const char *week) {
  const char *offsets[] = {"first", "second", "third", "fourth"};
  for (size_t i = 0; i < 5; ++i) {
    if (strcmp(week, offsets[i]) == 0) {
      return i * 7;
    }
  }
  return -1;
}

int meetup_day_of_month(unsigned int year, unsigned int month, const char *week,
                        const char *day_of_week) {
  struct tm time = {
      .tm_year = year - 1900,
      .tm_mon = month - 1,
      .tm_mday = 1,
  };
  mktime(&time);
  int target_day = day_to_tm_wday(day_of_week);
  if (strcmp(week, "teenth") == 0) {
    while (time.tm_mday < 13) {
      ++time.tm_mday;
      time.tm_wday = (time.tm_wday + 1) % 7;
    }
  } else if (strcmp(week, "last") == 0) {
    time = (struct tm){
        .tm_year = year - 1900,
        .tm_mon = month,
        .tm_mday = 0,
    };
    mktime(&time);
    while (time.tm_wday != target_day) {
      --time.tm_mday;
      time.tm_wday = time.tm_wday - 1 < 0 ? 6 : time.tm_wday - 1;
    }
    return time.tm_mday;
  } else {
    int offset = week_offset_in_tm_mday(week);
    for (int i = 0; i < offset; ++i) {
      ++time.tm_mday;
      time.tm_wday = (time.tm_wday + 1) % 7;
    }
  }
  while (time.tm_wday != target_day) {
    ++time.tm_mday;
    time.tm_wday = (time.tm_wday + 1) % 7;
  }
  return time.tm_mday;
}
