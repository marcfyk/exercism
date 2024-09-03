#ifndef REACT_H
#define REACT_H

#include <stddef.h>

struct reactor;
struct cell;

typedef int (*compute1)(int);
typedef int (*compute2)(int, int);

struct reactor *create_reactor(void);
// destroy_reactor should free all cells created under that reactor.
void destroy_reactor(struct reactor *);

struct cell *create_input_cell(struct reactor *, int initial_value);
struct cell *create_compute1_cell(struct reactor *, struct cell *, compute1);
struct cell *create_compute2_cell(struct reactor *, struct cell *,
                                  struct cell *, compute2);

int get_cell_value(struct cell *);
void set_cell_value(struct cell *, int new_value);

typedef void (*callback)(void *, int);
typedef int callback_id;

// The callback should be called with the same void * given in add_callback.
callback_id add_callback(struct cell *, void *, callback);
void remove_callback(struct cell *, callback_id);

#define CELL_CAPACITY 100
#define REFS_CAPACITY 100
#define CALLBACK_CAPACITY 100

typedef enum cell_type {
  CellTypeInput,
  CellTypeCompute1,
  CellTypeCompute2,
} cell_type_t;

typedef union func {
  int (*unary)(int);
  int (*binary)(int, int);
} func_t;

typedef struct cell {
  int value;
  cell_type_t type;
  struct cell *args[2];
  func_t func;
  size_t refs_size;
  struct cell *refs[REFS_CAPACITY];
  void *callback_tgts[CALLBACK_CAPACITY];
  size_t callbacks_size;
  callback callbacks[CALLBACK_CAPACITY];
} cell_t;

typedef struct reactor {
  size_t size;
  cell_t *cells[CELL_CAPACITY];
} reactor_t;

#endif
