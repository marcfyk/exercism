#include "yacht.h"

int score(const dice_t dice, const category_t category) {
  int dices[6] = {0};
  for (int i = 0; i < 5; ++i) {
    int d = dice.faces[i];
    if (d < 1 || d > 6) {
      return 0;
    }
    ++dices[d - 1];
  }
  int counts[6] = {0};
  for (int i = 0; i < 6; ++i) {
    int count = dices[i];
    ++counts[count];
  }
  int score = 0;
  switch (category) {
  case ONES:
    return dices[0];
  case TWOS:
    return 2 * dices[1];
  case THREES:
    return 3 * dices[2];
  case FOURS:
    return 4 * dices[3];
  case FIVES:
    return 5 * dices[4];
  case SIXES:
    return 6 * dices[5];
  case FULL_HOUSE:
    if (counts[2] != 1 || counts[3] != 1) {
      return 0;
    }
    for (int i = 0; i < 6; ++i) {
      score += (i + 1) * dices[i];
    }
    return score;
  case FOUR_OF_A_KIND:
    if (counts[4] == 0 && counts[5] == 0) {
      return 0;
    }
    for (int i = 0; i < 6; ++i) {
      if (dices[i] >= 4) {
        return (i + 1) * 4;
      }
    }
    return 0;
  case LITTLE_STRAIGHT:
    for (int i = 0; i < 5; ++i) {
      if (dices[i] == 0) {
        return 0;
      }
    }
    return 30;
  case BIG_STRAIGHT:
    for (int i = 1; i < 6; ++i) {
      if (dices[i] == 0) {
        return 0;
      }
    }
    return 30;
  case CHOICE:
    for (int i = 0; i < 6; ++i) {
      score += dices[i] * (i + 1);
    }
    return score;
  case YACHT:
    for (int i = 0; i < 6; ++i) {
      if (dices[i] == 5) {
        return 50;
      }
    }
    return 0;
  }
  return 0;
}
