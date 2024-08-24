#include "binary_search_tree.h"
#include <stdlib.h>

static node_t *node_alloc(int data, node_t *left, node_t *right) {
  node_t *n = malloc(sizeof(node_t));
  n->data = data;
  n->left = left;
  n->right = right;
  return n;
}

static void insert(node_t *root, int value) {
  node_t *n = root;
  while (n != NULL) {
    if (n->data > value) {
      if (n->left == NULL) {
        break;
      }
      n = n->left;
    } else if (n->data < value) {
      if (n->right == NULL) {
        break;
      }
      n = n->right;
    } else {
      break;
    }
  }
  if (n->data >= value) {
    n->left = node_alloc(value, n->left, NULL);
  } else if (n->data < value) {
    n->right = node_alloc(value, NULL, n->right);
  }
}

node_t *build_tree(int *tree_data, size_t tree_data_len) {
  if (tree_data_len == 0) {
    return NULL;
  }
  node_t *root = node_alloc(tree_data[0], NULL, NULL);
  for (size_t i = 1; i < tree_data_len; ++i) {
    insert(root, tree_data[i]);
  }
  return root;
}

void free_tree(node_t *tree) {
  if (tree == NULL) {
    return;
  }
  free_tree(tree->left);
  free_tree(tree->right);
  free(tree);
}

static size_t tree_size(node_t *tree) {
  if (tree == NULL) {
    return 0;
  }
  return 1 + tree_size(tree->left) + tree_size(tree->right);
}

static void inorder(int *index, int *sorted, node_t *tree) {
  if (tree == NULL) {
    return;
  }
  inorder(index, sorted, tree->left);
  sorted[(*index)++] = tree->data;
  inorder(index, sorted, tree->right);
}

int *sorted_data(node_t *tree) {
  size_t size = tree_size(tree);
  int *sorted = malloc(size * sizeof(int));
  int index = 0;
  inorder(&index, sorted, tree);
  return sorted;
}
