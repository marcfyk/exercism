#include "react.h"
#include <stdlib.h>

static void trigger_callbacks(cell_t *c);

struct reactor *create_reactor(void) {
  reactor_t *r = malloc(sizeof(reactor_t));
  r->size = 0;
  return r;
}

void destroy_reactor(reactor_t *r) {
  if (r == NULL) {
    return;
  }
  for (size_t i = 0; i < r->size; ++i) {
    if (r->cells[i] != NULL) {
      free(r->cells[i]);
    }
  }
  free(r);
}

cell_t *create_input_cell(reactor_t *r, int initial_value) {
  cell_t *cell = malloc(sizeof(cell_t));
  cell->type = CellTypeInput;
  cell->value = initial_value;
  cell->callbacks_size = 0;
  cell->refs_size = 0;
  r->cells[r->size++] = cell;
  return cell;
}

cell_t *create_compute1_cell(reactor_t *r, cell_t *c, compute1 f) {
  cell_t *cell = malloc(sizeof(cell_t));
  cell->type = CellTypeCompute1;
  cell->value = f(get_cell_value(c));
  cell->args[0] = c;
  cell->func.unary = f;
  cell->refs_size = 0;
  c->refs[c->refs_size++] = cell;
  cell->callbacks_size = 0;
  r->cells[r->size++] = cell;
  return cell;
}

cell_t *create_compute2_cell(reactor_t *r, cell_t *c1, cell_t *c2, compute2 f) {
  cell_t *cell = malloc(sizeof(cell_t));
  cell->type = CellTypeCompute2;
  cell->value = f(get_cell_value(c1), get_cell_value(c2));
  cell->args[0] = c1;
  cell->args[1] = c2;
  cell->func.binary = f;
  cell->refs_size = 0;
  c1->refs[c1->refs_size++] = cell;
  c2->refs[c2->refs_size++] = cell;
  cell->callbacks_size = 0;
  r->cells[r->size++] = cell;
  return cell;
}

int get_cell_value(cell_t *c) {
  switch (c->type) {
  case CellTypeInput:
    return c->value;
  case CellTypeCompute1:
    return c->func.unary(get_cell_value(c->args[0]));
  case CellTypeCompute2:
    return c->func.binary(get_cell_value(c->args[0]),
                          get_cell_value(c->args[1]));
  default:
    return -1;
  }
}

void set_cell_value(cell_t *c, int new_value) {
  c->value = new_value;
  for (size_t i = 0; i < c->refs_size; ++i) {
    cell_t *ref = c->refs[i];
    int original_value = ref->value;
    int new_ref_value = get_cell_value(ref);
    set_cell_value(ref, new_ref_value);
    if (new_ref_value != original_value) {
      trigger_callbacks(ref);
    }
  }
}

callback_id add_callback(cell_t *c, void *p, callback f) {
  c->callbacks[c->callbacks_size] = f;
  c->callback_tgts[c->callbacks_size] = p;
  return c->callbacks_size++;
}

void remove_callback(cell_t *c, callback_id id) {
  c->callbacks[id] = NULL;
  c->callback_tgts[id] = NULL;
}

static void trigger_callbacks(cell_t *c) {
  for (size_t i = 0; i < c->callbacks_size; ++i) {
    if (c->callbacks[i] != NULL) {
      c->callbacks[i](c->callback_tgts[i], c->value);
    }
  }
}
