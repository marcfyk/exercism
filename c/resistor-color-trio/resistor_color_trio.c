#include "resistor_color_trio.h"

resistor_value_t color_code(const resistor_band_t *resistor_bands) {
  long value = resistor_bands[0] * 10 + resistor_bands[1];
  for (int i = 0; i < (int)resistor_bands[2]; ++i) {
    value *= 10;
  }

  if (value >= DECIMAL_GIGA) {
    return (resistor_value_t){.value = value / DECIMAL_GIGA, .unit = GIGAOHMS};
  } else if (value >= DECIMAL_MEGA) {
    return (resistor_value_t){.value = value / DECIMAL_MEGA, .unit = MEGAOHMS};
  } else if (value >= DECIMAL_KILO) {
    return (resistor_value_t){.value = value / DECIMAL_KILO, .unit = KILOOHMS};
  } else {
    return (resistor_value_t){.value = value, .unit = OHMS};
  }
}
