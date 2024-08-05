#include "rna_transcription.h"
#include <stdlib.h>
#include <string.h>

char transcribe(char nucleotide);

char transcribe(char nucleotide) {
  switch (nucleotide) {
  case 'G':
    return 'C';
  case 'C':
    return 'G';
  case 'T':
    return 'A';
  case 'A':
    return 'U';
  default:
    return nucleotide;
  }
}

char *to_rna(const char *dna) {
  const int l = strlen(dna);
  char *rna = malloc(l * sizeof(char) + 1);
  for (int i = 0; i < l; ++i) {
    rna[i] = transcribe(dna[i]);
  }
  rna[l] = '\0';
  return rna;
}
