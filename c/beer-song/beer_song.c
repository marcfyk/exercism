#include "beer_song.h"
#include <stdint.h>
#include <stdio.h>

void write_verse(const int8_t bottles, const int8_t index, char **song);
void write_line_one(const int8_t bottles, char *song);
void write_line_two(const int8_t bottles, char *song);

void write_verse(const int8_t bottles, const int8_t index, char **song) {
  write_line_one(bottles, song[index]);
  write_line_two(bottles - 1, song[index + 1]);
}

void write_line_one(const int8_t bottles, char *song) {
  if (bottles == 0) {
    sprintf(song,
            "No more bottles of beer on the wall, no more bottles of beer.");
  } else if (bottles == 1) {
    sprintf(song, "1 bottle of beer on the wall, 1 bottle of beer.");
  } else {
    const char *fmt = "%u bottles of beer on the wall, %u bottles of beer.";
    int size = snprintf(NULL, 0, fmt, bottles, bottles);
    snprintf(song, size + 1, fmt, bottles, bottles);
  }
}
void write_line_two(const int8_t bottles, char *song) {
  if (bottles == -1) {
    sprintf(
        song,
        "Go to the store and buy some more, 99 bottles of beer on the wall.");
  } else if (bottles == 0) {
    sprintf(song, "Take it down and pass it around, no more bottles of beer "
                  "on the wall.");
  } else if (bottles == 1) {
    sprintf(song, "Take one down and pass it around, 1 bottle of beer "
                  "on the wall.");
  } else {
    const char *fmt =
        "Take one down and pass it around, %u bottles of beer on the wall.";
    int size = snprintf(NULL, 0, fmt, bottles);
    snprintf(song, size + 1, fmt, bottles);
  }
}

void recite(const int8_t start_bottles, const int8_t take_down, char **song) {
  int8_t number_of_bottles = start_bottles;
  for (int8_t i = 0; i < take_down; ++i) {
    write_verse(number_of_bottles--, i * 3, song);
  }
}
