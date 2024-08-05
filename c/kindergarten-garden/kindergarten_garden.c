#include "kindergarten_garden.h"
#include <string.h>

#define ALICE "Alice"
#define BOB "Bob"
#define CHARLIE "Charlie"
#define DAVID "David"
#define EVE "Eve"
#define FRED "Fred"
#define GINNY "Ginny"
#define HARRIET "Harriet"
#define ILEANA "Ileana"
#define JOSEPH "Joseph"
#define KINCAID "Kincaid"
#define LARRY "Larry"

plant_t plant(char c);

plant_t plant(char c) {
  switch (c) {
  case 'C':
    return CLOVER;
  case 'G':
    return GRASS;
  case 'R':
    return RADISHES;
  case 'V':
    return VIOLETS;
  default:
    return -1;
  }
}

plants_t plants(const char *diagram, const char *student) {
  children_t c;
  if (strncmp(student, ALICE, sizeof(ALICE)) == 0) {
    c = CHILDREN_ALICE;
  } else if (strncmp(student, BOB, sizeof(BOB)) == 0) {
    c = CHILDREN_BOB;
  } else if (strncmp(student, CHARLIE, sizeof(CHARLIE)) == 0) {
    c = CHILDREN_CHARLIE;
  } else if (strncmp(student, DAVID, sizeof(DAVID)) == 0) {
    c = CHILDREN_DAVID;
  } else if (strncmp(student, EVE, sizeof(EVE)) == 0) {
    c = CHILDREN_EVE;
  } else if (strncmp(student, FRED, sizeof(FRED)) == 0) {
    c = CHILDREN_FRED;
  } else if (strncmp(student, GINNY, sizeof(GINNY)) == 0) {
    c = CHILDREN_GINNY;
  } else if (strncmp(student, HARRIET, sizeof(HARRIET)) == 0) {
    c = CHILDREN_HARRIET;
  } else if (strncmp(student, ILEANA, sizeof(ILEANA)) == 0) {
    c = CHILDREN_ILEANA;
  } else if (strncmp(student, JOSEPH, sizeof(JOSEPH)) == 0) {
    c = CHILDREN_JOSEPH;
  } else if (strncmp(student, KINCAID, sizeof(KINCAID)) == 0) {
    c = CHILDREN_KINCAID;
  } else if (strncmp(student, LARRY, sizeof(LARRY)) == 0) {
    c = CHILDREN_LARRY;
  } else {
    return (plants_t){0};
  }

  int offset = 0;
  while (diagram[offset++] != '\n')
    ;

  plants_t p;
  p.plants[0] = plant(diagram[c * 2]);
  p.plants[1] = plant(diagram[c * 2 + 1]);
  p.plants[2] = plant(diagram[offset + c * 2]);
  p.plants[3] = plant(diagram[offset + c * 2 + 1]);
  return p;
}
