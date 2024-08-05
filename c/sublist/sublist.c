#include "sublist.h"
#include <stdbool.h>
#include <string.h>

comparison_result_t check_lists(const int *list_to_compare,
                                const int *base_list,
                                const size_t list_to_compare_element_count,
                                const size_t base_list_element_count) {
  if (list_to_compare_element_count == 0 && base_list_element_count == 0) {
    return EQUAL;
  }
  if (list_to_compare_element_count == 0) {
    return SUBLIST;
  }
  if (base_list_element_count == 0) {
    return SUPERLIST;
  }
  if (list_to_compare_element_count < base_list_element_count) {
    size_t i = 0;
    while (i < base_list_element_count) {
      if (base_list[i] != list_to_compare[0]) {
        ++i;
        continue;
      }
      size_t i_candidate = i;
      size_t j = 0;
      for (j = 0; j < list_to_compare_element_count; ++j) {
        if (list_to_compare[j] != base_list[i_candidate++]) {
          break;
        }
      }
      if (j == list_to_compare_element_count) {
        return SUBLIST;
      }
      ++i;
    }
    return UNEQUAL;
  } else if (list_to_compare_element_count > base_list_element_count) {
    comparison_result_t result =
        check_lists(base_list, list_to_compare, base_list_element_count,
                    list_to_compare_element_count);
    return result == SUBLIST ? SUPERLIST : result;
  } else {
    return memcmp(list_to_compare, base_list,
                  sizeof(int) * base_list_element_count) == 0
               ? EQUAL
               : UNEQUAL;
  }
}
