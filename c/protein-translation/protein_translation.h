#ifndef PROTEIN_TRANSLATION_H
#define PROTEIN_TRANSLATION_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#define MAX_PROTEINS 10

typedef enum {
  Methionine,
  Phenylalanine,
  Leucine,
  Serine,
  Tyrosine,
  Cysteine,
  Tryptophan,
  Stop,
} protein_t;

typedef struct {
  const char **codons;
  const uint8_t size;
} protein_codons_t;

typedef struct {
  bool valid;
  size_t count;
  protein_t proteins[MAX_PROTEINS];
} proteins_t;

proteins_t proteins(const char *const rna);

#endif
