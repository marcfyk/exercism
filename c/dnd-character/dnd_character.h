#ifndef DND_CHARACTER_H
#define DND_CHARACTER_H

#define ROLLS 4
#define ROLL_MAX 6
#define ROLL_MIN 1
#define ROLL_RANGE ROLL_MAX - ROLL_MIN + 1

typedef struct {
  int strength;
  int dexterity;
  int constitution;
  int intelligence;
  int wisdom;
  int charisma;
  int hitpoints;
} dnd_character_t;

int ability(void);
int modifier(const int score);
dnd_character_t make_dnd_character(void);

#endif
