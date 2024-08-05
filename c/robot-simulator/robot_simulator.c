#include "robot_simulator.h"

robot_status_t robot_create(const robot_direction_t direction, const int x,
                            const int y) {
  return (robot_status_t){.direction = direction, .position = {.x = x, .y = y}};
}

void advance(robot_status_t *robot);
void turn_right(robot_status_t *robot);
void turn_left(robot_status_t *robot);

void advance(robot_status_t *robot) {
  switch (robot->direction) {
  case DIRECTION_NORTH:
    ++robot->position.y;
    break;
  case DIRECTION_SOUTH:
    --robot->position.y;
    break;
  case DIRECTION_EAST:
    ++robot->position.x;
    break;
  case DIRECTION_WEST:
    --robot->position.x;
    break;
  }
}

void turn_right(robot_status_t *robot) {
  switch (robot->direction) {
  case DIRECTION_NORTH:
    robot->direction = DIRECTION_EAST;
    break;
  case DIRECTION_SOUTH:
    robot->direction = DIRECTION_WEST;
    break;
  case DIRECTION_EAST:
    robot->direction = DIRECTION_SOUTH;
    break;
  case DIRECTION_WEST:
    robot->direction = DIRECTION_NORTH;
    break;
  }
}

void turn_left(robot_status_t *robot) {
  switch (robot->direction) {
  case DIRECTION_NORTH:
    robot->direction = DIRECTION_WEST;
    break;
  case DIRECTION_SOUTH:
    robot->direction = DIRECTION_EAST;
    break;
  case DIRECTION_EAST:
    robot->direction = DIRECTION_NORTH;
    break;
  case DIRECTION_WEST:
    robot->direction = DIRECTION_SOUTH;
    break;
  }
}

void robot_move(robot_status_t *robot, const char *commands) {
  for (int i = 0; commands[i] != '\0'; ++i) {
    switch (commands[i]) {
    case COMMAND_ADVANCE:
      advance(robot);
      break;
    case COMMAND_RIGHT:
      turn_right(robot);
      break;
    case COMMAND_LEFT:
      turn_left(robot);
      break;
    }
  }
}
