#include "list_ops.h"
#include <stdlib.h>
#include <string.h>

list_t *alloc_list(size_t length);
list_t *alloc_list(size_t length) {
  list_t *l = malloc(sizeof(list_t) + length * sizeof(list_element_t));
  l->length = length;
  return l;
}

list_t *new_list(size_t length, list_element_t elements[]) {
  list_t *l = alloc_list(length);
  memcpy(l->elements, elements, length * sizeof(list_element_t));
  return l;
}

list_t *append_list(list_t *list1, list_t *list2) {
  list_t *l = alloc_list(list1->length + list2->length);
  memcpy(l->elements, list1->elements, list1->length * sizeof(list_element_t));
  memcpy(l->elements + list1->length, list2->elements,
         list2->length * sizeof(list_element_t));
  return l;
}

list_t *filter_list(list_t *list, bool (*filter)(list_element_t)) {
  size_t length = 0;
  for (size_t i = 0; i < list->length; ++i) {
    if (filter(list->elements[i])) {
      ++length;
    }
  }
  list_t *l = alloc_list(length);
  int index = 0;
  for (size_t i = 0; i < list->length; ++i) {
    if (filter(list->elements[i])) {
      l->elements[index++] = list->elements[i];
    }
  }
  return l;
}

size_t length_list(list_t *list) { return list->length; }

list_t *map_list(list_t *list, list_element_t (*map)(list_element_t)) {
  list_t *l = alloc_list(list->length);
  for (size_t i = 0; i < list->length; ++i) {
    l->elements[i] = map(list->elements[i]);
  }
  return l;
}

list_element_t foldl_list(list_t *list, list_element_t initial,
                          list_element_t (*foldl)(list_element_t,
                                                  list_element_t)) {
  list_element_t result = initial;
  for (size_t i = 0; i < list->length; ++i) {
    result = foldl(list->elements[i], result);
  }
  return result;
}

list_element_t foldr_list(list_t *list, list_element_t initial,
                          list_element_t (*foldr)(list_element_t,
                                                  list_element_t)) {
  list_element_t result = initial;
  for (int i = list->length - 1; i >= 0; --i) {
    result = foldr(list->elements[i], result);
  }
  return result;
}

list_t *reverse_list(list_t *list) {
  list_t *l = alloc_list(list->length);
  for (size_t i = 0; i < l->length; ++i) {
    l->elements[i] = list->elements[l->length - i - 1];
  }
  return l;
}

void delete_list(list_t *list) {
  if (list == NULL) {
    return;
  }
  free(list);
}
