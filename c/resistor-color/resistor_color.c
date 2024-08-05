#include "resistor_color.h"
#include <stdint.h>

const resistor_band_t resistor_bands[] = {
    BLACK, BROWN, RED, ORANGE, YELLOW, GREEN, BLUE, VIOLET, GREY, WHITE,
};

uint16_t color_code(const resistor_band_t resistor_band) {
  return resistor_band;
}

const resistor_band_t *colors(void) { return resistor_bands; }
