#include "grade_school.h"
#include <string.h>

void init_roster(roster_t *roster) { roster->count = 0; }

bool add_student(roster_t *roster, const char *name, const uint8_t grade) {
  size_t insert_index = 0;
  while (insert_index < roster->count) {
    student_t student = roster->students[insert_index];
    int cmp = strcmp(name, student.name);
    if (cmp == 0) {
      return false;
    }
    if (grade < student.grade) {
      break;
    }
    if (grade == student.grade && cmp < 0) {
      break;
    }
    ++insert_index;
  }
  for (size_t i = roster->count++; i > insert_index; --i) {
    roster->students[i] = roster->students[i - 1];
  }
  student_t s = {.grade = grade};
  strcpy(s.name, name);
  roster->students[insert_index] = s;
  return true;
}

roster_t get_grade(roster_t *roster, uint8_t grade) {
  roster_t r = {.count = 0};

  size_t start = 0;
  while (start < roster->count && roster->students[start].grade != grade) {
    start++;
  }
  for (size_t i = start;
       i < roster->count && roster->students[i].grade == grade; ++i) {
    ++r.count;
  }
  memcpy(r.students, &roster->students[start], r.count * sizeof(student_t));
  return r;
}
