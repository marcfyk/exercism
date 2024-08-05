#include "linked_list.h"
#include <stdlib.h>

typedef struct list_node {
  struct list_node *prev, *next;
  ll_data_t data;
} list_node_t;

typedef struct list {
  list_node_t *first, *last;
} list_t;

list_t *list_create(void) {
  struct list *l = malloc(sizeof(struct list));
  l->first = NULL;
  l->last = NULL;
  return l;
}

size_t list_count(const list_t *list) {
  int size = 0;
  list_node_t *ptr = list->first;
  while (ptr != NULL) {
    ++size;
    ptr = ptr->next;
  }
  return size;
}

void list_push(list_t *list, ll_data_t item_data) {
  list_node_t *n = malloc(sizeof(list_node_t));
  n->data = item_data;
  n->next = NULL;
  list_node_t *last = list->last;
  n->prev = last;
  if (last == NULL) {
    list->first = n;
    list->last = n;
    return;
  }
  last->next = n;
  list->last = n;
}

ll_data_t list_pop(list_t *list) {
  list_node_t *last = list->last;
  list->last = last->prev;
  if (list->last == NULL) {
    list->first = NULL;
  } else {
    list->last->next = NULL;
  }
  ll_data_t data = last->data;
  free(last);
  return data;
}

void list_unshift(list_t *list, ll_data_t item_data) {
  list_node_t *n = malloc(sizeof(list_node_t));
  n->data = item_data;
  n->prev = NULL;
  n->next = list->first;
  if (list->first == NULL) {
    list->first = n;
    list->last = n;
  } else {
    list->first->prev = n;
    list->first = n;
  }
}

ll_data_t list_shift(list_t *list) {
  list_node_t *n = list->first;
  ll_data_t data = n->data;
  list->first = n->next;
  if (list->first == NULL) {
    list->last = NULL;
  } else {
    list->first->prev = NULL;
  }
  free(n);
  return data;
}

void list_delete(list_t *list, ll_data_t data) {
  list_node_t *n = list->first;
  while (n != NULL) {
    if (n->data == data) {
      break;
    }
    n = n->next;
  }
  if (n == NULL) {
    return;
  }
  if (n->prev != NULL) {
    n->prev->next = n->next;
  } else {
    list->first = n->next;
  }
  if (n->next != NULL) {
    n->next->prev = n->prev;
  } else {
    list->last = n->prev;
  }
  free(n);
}

void list_destroy(list_t *list) {
  if (list == NULL) {
    return;
  }
  list_node_t *ptr = list->first;
  while (ptr != NULL) {
    list_node_t *next = ptr->next;
    free(ptr);
    ptr = next;
  }
  free(list);
}
