#include "resistor_color_duo.h"
#include <stdint.h>

uint16_t color_code(const resistor_band_t *resistor_bands) {
  return resistor_bands[0] * 10 + resistor_bands[1];
}
