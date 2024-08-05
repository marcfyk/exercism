#ifndef SUBLIST_H
#define SUBLIST_H

#include <stddef.h>

typedef enum { EQUAL, UNEQUAL, SUBLIST, SUPERLIST } comparison_result_t;

comparison_result_t check_lists(const int *list_to_compare,
                                const int *base_list,
                                const size_t list_to_compare_element_count,
                                const size_t base_list_element_count);

#endif
