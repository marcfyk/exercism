#include "two_bucket.h"

#include <stdlib.h>

static bucket_t new_bucket(bucket_id_t id, bucket_liters_t capacity) {
  return (bucket_t){.id = id, .volume = 0, .capacity = capacity};
}
static void empty_bucket(bucket_t *b) { b->volume = 0; }
static void fill_bucket(bucket_t *b) { b->volume = b->capacity; }
static void pour_bucket(bucket_t *src, bucket_t *tgt) {
  bucket_liters_t tgt_delta = tgt->capacity - tgt->volume;
  bucket_liters_t delta = tgt_delta < src->volume ? tgt_delta : src->volume;
  src->volume -= delta;
  tgt->volume += delta;
}

static state_t initial_state(bucket_liters_t bucket_1_size,
                             bucket_liters_t bucket_2_size,
                             bucket_id_t start_bucket) {
  bucket_t b1 = new_bucket(BUCKET_ID_1, bucket_1_size);
  bucket_t b2 = new_bucket(BUCKET_ID_2, bucket_2_size);
  state_t s;
  if (start_bucket == BUCKET_ID_1) {
    s.start = b1;
    s.other = b2;
  } else {
    s.start = b2;
    s.other = b1;
  }
  fill_bucket(&s.start);
  s.moves = 1;
  return s;
}
static int hash_state(state_t *s) {
  return s->start.volume * (s->other.capacity + 1) + s->other.volume;
}
static state_t pour_to_start(state_t *s) {
  state_t s1 = *s;
  pour_bucket(&s1.other, &s1.start);
  ++s1.moves;
  return s1;
}
static state_t pour_to_other(state_t *s) {
  state_t s1 = *s;
  pour_bucket(&s1.start, &s1.other);
  ++s1.moves;
  return s1;
}
static state_t empty_start(state_t *s) {
  state_t s1 = *s;
  empty_bucket(&s1.start);
  ++s1.moves;
  return s1;
}
static state_t empty_other(state_t *s) {
  state_t s1 = *s;
  empty_bucket(&s1.other);
  ++s1.moves;
  return s1;
}
static state_t fill_start(state_t *s) {
  state_t s1 = *s;
  fill_bucket(&s1.start);
  ++s1.moves;
  return s1;
}
static state_t fill_other(state_t *s) {
  state_t s1 = *s;
  fill_bucket(&s1.other);
  ++s1.moves;
  return s1;
}

static bool has_reached_goal(state_t *s, bucket_liters_t goal_volume) {
  return s->start.volume == goal_volume || s->other.volume == goal_volume;
}

static void init_queue(queue_t *q, int capacity) {
  q->head = 0;
  q->size = 0;
  q->data = malloc(sizeof(state_t) * capacity);
}
static state_t *pop_queue(queue_t *q) {
  --q->size;
  return &q->data[q->head++];
}
static void push_queue(queue_t *q, state_t s) {
  q->data[q->head + q->size++] = s;
}
static bool is_empty_queue(queue_t *q) { return q->size == 0; }

bucket_result_t measure(bucket_liters_t bucket_1_size,
                        bucket_liters_t bucket_2_size,
                        bucket_liters_t goal_volume, bucket_id_t start_bucket) {
  state_t state = initial_state(bucket_1_size, bucket_2_size, start_bucket);
  int max_possible_states =
      (state.start.capacity + 1) * (state.other.capacity + 1);
  bool *visited = calloc(max_possible_states, sizeof(bool));
  queue_t q;
  init_queue(&q, max_possible_states);
  push_queue(&q, state);

  state_t goal_state = {.moves = -1};
  while (!is_empty_queue(&q)) {
    state_t *s = pop_queue(&q);

    if (s->start.volume == 0 && s->other.volume == s->other.capacity) {
      continue;
    }

    if (has_reached_goal(s, goal_volume)) {
      goal_state = *s;
      break;
    }

    int h = hash_state(s);
    if (visited[h]) {
      continue;
    }
    visited[h] = true;

    state_t s1 = pour_to_other(s);
    int h1 = hash_state(&s1);
    if (!visited[h1]) {
      push_queue(&q, s1);
    }

    state_t s2 = pour_to_start(s);
    int h2 = hash_state(&s2);
    pour_bucket(&s2.other, &s2.start);
    if (!visited[h2]) {
      push_queue(&q, s2);
    }

    state_t s3 = empty_start(s);
    int h3 = hash_state(&s3);
    if (!visited[h3]) {
      push_queue(&q, s3);
    }

    state_t s4 = empty_other(s);
    int h4 = hash_state(&s4);
    if (!visited[h4]) {
      push_queue(&q, s4);
    }

    state_t s5 = fill_start(s);
    int h5 = hash_state(&s5);
    if (!visited[h5]) {
      push_queue(&q, s5);
    }

    state_t s6 = fill_other(s);
    int h6 = hash_state(&s6);
    if (!visited[h6]) {
      push_queue(&q, s6);
    }
  }
  free(visited);
  free(q.data);

  bucket_result_t result = {0};
  if (goal_state.moves == -1) {
    return result;
  }

  result.possible = true;
  result.move_count = goal_state.moves;
  if (goal_state.start.volume == goal_volume) {
    result.goal_bucket = goal_state.start.id;
    result.other_bucket_liters = goal_state.other.volume;
  } else {
    result.goal_bucket = goal_state.other.id;
    result.other_bucket_liters = goal_state.start.volume;
  }
  return result;
}
