#include "allergies.h"

bool is_allergic_to(const allergen_t allergen, const int score) {
  int n = 1;
  for (allergen_t i = 0; i < allergen; ++i) {
    n *= 2;
  }
  return (score & n) > 0;
}

allergen_list_t get_allergens(const int score) {

  allergen_list_t list = {0};
  int n = 1;
  for (allergen_t i = 0; i < ALLERGEN_COUNT; ++i) {
    if (score & n) {
      ++list.count;
      list.allergens[i] = true;
    }
    n *= 2;
  }
  return list;
}
