#ifndef ROBOT_SIMULATOR_H
#define ROBOT_SIMULATOR_H

typedef enum {
  DIRECTION_NORTH = 0,
  DIRECTION_EAST,
  DIRECTION_SOUTH,
  DIRECTION_WEST,
} robot_direction_t;

typedef enum {
  COMMAND_ADVANCE = 'A',
  COMMAND_RIGHT = 'R',
  COMMAND_LEFT = 'L',
} command_t;

typedef struct {
  int x;
  int y;
} robot_position_t;

typedef struct {
  robot_direction_t direction;
  robot_position_t position;
} robot_status_t;

robot_status_t robot_create(const robot_direction_t direction, const int x,
                            const int y);
void robot_move(robot_status_t *robot, const char *commands);

#endif
