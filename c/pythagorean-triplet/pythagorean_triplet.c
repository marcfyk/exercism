#include "pythagorean_triplet.h"
#include <stdlib.h>

triplets_t *triplets_with_sum(uint16_t sum) {
  triplets_t *triplets = malloc(sizeof(triplets_t));
  triplets->triplets = malloc(sum / 3 * sizeof(triplet_t));
  triplets->count = 0;
  for (int i = 1; i < sum; ++i) {
    for (int j = i + 1; j < sum; ++j) {
      int k = sum - i - j;
      if (j >= k || j >= sum) {
        continue;
      }
      if (i * i + j * j != k * k) {
        continue;
      }
      triplets->triplets[triplets->count++] = (triplet_t){
          .a = i,
          .b = j,
          .c = k,
      };
    }
  }
  return triplets;
}

void free_triplets(triplets_t *triplets) {
  if (triplets == NULL) {
    return;
  }
  if (triplets->triplets != NULL) {
    free(triplets->triplets);
  }
  free(triplets);
}
