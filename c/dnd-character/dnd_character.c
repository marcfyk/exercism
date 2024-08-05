#include "dnd_character.h"
#include <math.h>
#include <stdlib.h>

int ability(void) {
  int sum = 0;
  int min = ROLL_MAX + 1;
  for (int i = 0; i < ROLLS; ++i) {
    const int r = (rand() % ROLL_RANGE) + ROLL_MIN;
    sum += r;
    min = min < r ? min : r;
  }
  return sum - min;
}

int modifier(const int score) { return floor((double)(score - 10) / 2); }

dnd_character_t make_dnd_character(void) {
  dnd_character_t c = {
      .strength = ability(),
      .dexterity = ability(),
      .constitution = ability(),
      .intelligence = ability(),
      .wisdom = ability(),
      .charisma = ability(),
  };
  c.hitpoints = 10 + modifier(c.constitution);
  return c;
}
