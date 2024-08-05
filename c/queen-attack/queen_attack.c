#include "queen_attack.h"
#include <stdbool.h>
#include <stdlib.h>

bool is_valid_index(const int index);
bool is_valid_position(const position_t position);

bool is_valid_index(const int index) { return index >= 0 && index < 8; }

bool is_valid_position(const position_t position) {
  return is_valid_index(position.row) && is_valid_index(position.column);
}

attack_status_t can_attack(const position_t queen_1, const position_t queen_2) {
  if (!is_valid_position(queen_1) || !is_valid_position(queen_2)) {
    return INVALID_POSITION;
  }
  if (queen_1.row == queen_2.row && queen_1.column == queen_2.column) {
    return INVALID_POSITION;
  }
  if (queen_1.row == queen_2.row) {
    return CAN_ATTACK;
  }
  if (queen_1.column == queen_2.column) {
    return CAN_ATTACK;
  }
  const int row_delta = abs(queen_1.row - queen_2.row);
  const int column_delta = abs(queen_1.column - queen_2.column);
  if (row_delta == column_delta) {
    return CAN_ATTACK;
  }
  return CAN_NOT_ATTACK;
}
