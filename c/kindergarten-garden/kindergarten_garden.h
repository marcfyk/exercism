#ifndef KINDERGARTEN_GARDEN_H
#define KINDERGARTEN_GARDEN_H

typedef enum {
  CHILDREN_ALICE,
  CHILDREN_BOB,
  CHILDREN_CHARLIE,
  CHILDREN_DAVID,
  CHILDREN_EVE,
  CHILDREN_FRED,
  CHILDREN_GINNY,
  CHILDREN_HARRIET,
  CHILDREN_ILEANA,
  CHILDREN_JOSEPH,
  CHILDREN_KINCAID,
  CHILDREN_LARRY,
} children_t;

typedef enum { CLOVER = 0, GRASS = 1, RADISHES = 2, VIOLETS = 3 } plant_t;

typedef struct {
  plant_t plants[4];
} plants_t;

plants_t plants(const char *diagram, const char *student);

#endif
