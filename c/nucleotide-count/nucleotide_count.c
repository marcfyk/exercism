#include "nucleotide_count.h"
#include <stdio.h>
#include <stdlib.h>

#include <stdint.h>

typedef enum {
  ADENINE = 'A',
  CYTOSINE = 'C',
  GUANINE = 'G',
  THYMINE = 'T',
} nucleotide_t;

typedef struct {
  uint8_t adenine;
  uint8_t cytosine;
  uint8_t guanine;
  uint8_t thymine;
} nucleotide_counts_t;

char *count(const char *dna_strand) {
  if (dna_strand == NULL) {
    return NULL;
  }
  nucleotide_counts_t counts = {0};
  for (int i = 0; dna_strand[i] != '\0'; ++i) {
    switch (dna_strand[i]) {
    case ADENINE:
      ++counts.adenine;
      break;
    case CYTOSINE:
      ++counts.cytosine;
      break;
    case GUANINE:
      ++counts.guanine;
      break;
    case THYMINE:
      ++counts.thymine;
      break;
    default:
      return calloc(1, sizeof(char));
    }
  }
  const char *format = "A:%u C:%u G:%u T:%u";
  int size = snprintf(NULL, 0, format, counts.adenine, counts.cytosine,
                      counts.guanine, counts.thymine);
  char *result = malloc(size + 1);
  snprintf(result, size + 1, format, counts.adenine, counts.cytosine,
           counts.guanine, counts.thymine);
  return result;
}
