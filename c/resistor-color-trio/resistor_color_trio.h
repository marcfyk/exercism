#ifndef RESISTOR_COLOR_TRIO_H
#define RESISTOR_COLOR_TRIO_H

#include <stdint.h>

typedef enum {
  BLACK,
  BROWN,
  RED,
  ORANGE,
  YELLOW,
  GREEN,
  BLUE,
  VIOLET,
  GREY,
  WHITE,
} resistor_band_t;

typedef enum {
  OHMS,
  KILOOHMS,
  MEGAOHMS,
  GIGAOHMS,
} unit_t;

typedef enum {
  DECIMAL_KILO = 1000,
  DECIMAL_MEGA = 1000000,
  DECIMAL_GIGA = 1000000000,
} decimal_t;

typedef struct {
  uint16_t value;
  unit_t unit;
} resistor_value_t;

resistor_value_t color_code(const resistor_band_t *resistor_bands);

#endif
