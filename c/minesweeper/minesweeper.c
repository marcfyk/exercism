#include "minesweeper.h"
#include <stdlib.h>
#include <string.h>

char **annotate(const char **minefield, const size_t rows) {
  if (minefield == NULL || rows == 0) {
    return NULL;
  }
  size_t cols = strlen(minefield[0]);
  char **annotated_minefield = malloc((rows + 1) * sizeof(char *));
  annotated_minefield[rows] = NULL;
  for (size_t i = 0; i < rows; ++i) {
    annotated_minefield[i] = malloc((cols + 1) * sizeof(char));
    strcpy(annotated_minefield[i], minefield[i]);
    for (size_t j = 0; j < cols; ++j) {
      if (minefield[i][j] != ' ') {
        annotated_minefield[i][j] = minefield[i][j];
        continue;
      }
      int count = 0;
      if (i > 0) {
        count = minefield[i - 1][j] == '*' ? count + 1 : count;
        count = j > 0 && minefield[i - 1][j - 1] == '*' ? count + 1 : count;
        count =
            j < cols - 1 && minefield[i - 1][j + 1] == '*' ? count + 1 : count;
      }
      if (i < rows - 1) {
        count = minefield[i + 1][j] == '*' ? count + 1 : count;
        count = j > 0 && minefield[i + 1][j - 1] == '*' ? count + 1 : count;
        count =
            j < cols - 1 && minefield[i + 1][j + 1] == '*' ? count + 1 : count;
      }
      count = j > 0 && minefield[i][j - 1] == '*' ? count + 1 : count;
      count = j < cols - 1 && minefield[i][j + 1] == '*' ? count + 1 : count;
      annotated_minefield[i][j] = count > 0 ? count + '0' : ' ';
    }
  }
  return annotated_minefield;
}

void free_annotation(char **annotation) {
  if (annotation == NULL) {
    return;
  }
  for (int i = 0; annotation[i] != NULL; ++i) {
    free(annotation[i]);
  }
  free(annotation);
}
