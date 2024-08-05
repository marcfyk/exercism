#include "binary_search.h"

const int *binary_search(const int value, const int *arr, const size_t length) {
  if (arr == NULL || length == 0) {
    return NULL;
  }
  int left = 0;
  int right = length - 1;
  while (left <= right) {
    const int mid = (left + right) / 2;
    if (arr[mid] < value) {
      left = mid + 1;
    } else if (arr[mid] > value) {
      right = mid - 1;
    } else {
      return &arr[mid];
    }
  }
  return NULL;
}
