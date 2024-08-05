#include "protein_translation.h"
#include <string.h>

static const char *codon_methionine[] = {"AUG"};
static const char *codon_phenylalanine[] = {"UUU", "UUC"};
static const char *codon_leucine[] = {"UUA", "UUG"};
static const char *codon_serine[] = {"UCU", "UCC", "UCA", "UCG"};
static const char *codon_tyrosine[] = {"UAU", "UAC"};
static const char *codon_cysteine[] = {"UGU", "UGC"};
static const char *codon_tryptophan[] = {"UGG"};
static const char *codon_stop[] = {"UAA", "UAG", "UGA"};

static const protein_codons_t methionine = {
    .codons = codon_methionine,
    .size = 1,
};
static const protein_codons_t phenylalanine = {
    .codons = codon_phenylalanine,
    .size = 2,
};
static const protein_codons_t leucine = {
    .codons = codon_leucine,
    .size = 2,
};
static const protein_codons_t serine = {
    .codons = codon_serine,
    .size = 4,
};
static const protein_codons_t tyrosine = {
    .codons = codon_tyrosine,
    .size = 2,
};
static const protein_codons_t cysteine = {
    .codons = codon_cysteine,
    .size = 2,
};
static const protein_codons_t tryptophan = {
    .codons = codon_tryptophan,
    .size = 1,
};
static const protein_codons_t stop = {
    .codons = codon_stop,
    .size = 3,
};

static const protein_codons_t protein_codons[] = {
    methionine, phenylalanine, leucine,    serine,
    tyrosine,   cysteine,      tryptophan, stop,
};

bool does_protein_match(char codon[4], protein_t protein);

bool does_protein_match(char codon[4], protein_t protein) {
  protein_codons_t codons = protein_codons[protein];
  for (int i = 0; i < codons.size; ++i) {
    const char *c = codons.codons[i];
    if (strncmp(codon, c, 3) == 0) {
      return true;
    }
  }
  return false;
}

proteins_t proteins(const char *const rna) {
  proteins_t p = {0};
  int i = 0;
  char buffer[4] = {0};
  for (i = 0; rna[i] != '\0'; i += 3) {
    strncpy(buffer, &rna[i], 3);
    if (buffer[3] != '\0') {
      return (proteins_t){0};
    }
    bool protein_matched = false;
    bool found_stop = false;
    for (int j = 0; j < Tryptophan + 1; ++j) {
      protein_t protein = j;
      if (does_protein_match(buffer, Stop)) {
        found_stop = true;
        break;
      }
      if (does_protein_match(buffer, protein)) {
        p.proteins[p.count++] = protein;
        protein_matched = true;
        break;
      }
    }
    if (found_stop) {
      break;
    }
    if (!protein_matched) {
      return (proteins_t){0};
    }
  }
  if (i % 3 != 0) {
    return (proteins_t){0};
  }
  p.valid = true;
  return p;
}
