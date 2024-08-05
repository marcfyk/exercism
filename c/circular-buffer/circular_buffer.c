#include "circular_buffer.h"

#include <errno.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

circular_buffer_t *new_circular_buffer(size_t capacity) {
  circular_buffer_t *c = malloc(sizeof(circular_buffer_t));
  c->capacity = capacity;
  c->values = malloc(sizeof(buffer_value_t) * capacity);
  c->start = 0;
  c->size = 0;
  return c;
}

int16_t write(circular_buffer_t *buffer, buffer_value_t value) {
  if (buffer->size >= buffer->capacity) {
    errno = ENOBUFS;
    return EXIT_FAILURE;
  }
  int write_index = (buffer->start + buffer->size) % buffer->capacity;
  buffer->values[write_index] = value;
  ++buffer->size;
  return EXIT_SUCCESS;
}

int16_t overwrite(circular_buffer_t *buffer, const buffer_value_t value) {
  if (buffer->capacity == 0) {
    errno = ENOBUFS;
    return EXIT_FAILURE;
  }
  int write_index = (buffer->start + buffer->size) % buffer->capacity;
  buffer->values[write_index] = value;
  if (write_index != buffer->start) {
    ++buffer->size;
  } else {
    buffer->start = (buffer->start + 1) % buffer->capacity;
  }
  return EXIT_SUCCESS;
}

int16_t read(circular_buffer_t *buffer, buffer_value_t *value) {
  if (buffer->size == 0) {
    errno = ENODATA;
    return EXIT_FAILURE;
  }
  *value = buffer->values[buffer->start];
  buffer->start = (buffer->start + 1) % buffer->capacity;
  --buffer->size;
  return EXIT_SUCCESS;
}

void delete_buffer(circular_buffer_t *buffer) {
  if (buffer == NULL) {
    return;
  }
  if (buffer->values != NULL) {
    free(buffer->values);
  }
  free(buffer);
}

void clear_buffer(circular_buffer_t *buffer) {
  buffer->size = 0;
  memset(buffer->values, 0, buffer->capacity * sizeof(buffer_value_t));
}
