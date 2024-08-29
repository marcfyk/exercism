#include "knapsack.h"
#include <stdlib.h>

int maximum_value(int maximum_weight, item_t *items, size_t item_count) {
  if (item_count == 0) {
    return 0;
  }
  int *data = calloc(maximum_weight + 1, sizeof(int));
  for (size_t i = 0; i < item_count; ++i) {
    int weight = items[i].weight;
    for (int j = maximum_weight; j >= weight; --j) {
      int take = data[j - weight] + items[i].value;
      int dont_take = data[j];
      data[j] = dont_take > take ? dont_take : take;
    }
  }
  int result = data[maximum_weight];
  free(data);
  return result;
}
