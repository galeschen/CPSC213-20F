#include <stdlib.h>

#include "mymalloc.h"

/* Feel free to change/remove these variables and/or add your own. */
/* NOTE: The 'static' keyword makese these variables private to this file. 
   If you leave it off, the variable is still static, of course, but it also
   has global scope (can be accessed anywhere in the program).  Adding the 'static'
   keyword changes the variables to have "file" scope. */

// Base address of the allocated heap.
static char *heap;
// Size of the complete heap.
static int heapsize;
// Next unallocated location in the heap.
static int top;

/* Initialize your memory manager to manage the given heap. */
void mymalloc_init(char *_heap, int _heapsize) {
  heap = _heap;
  heapsize = _heapsize;
  top = 0;
  /* TODO: Any other initialization you want to do */
  /* NOTE! Each call to mymalloc_init should initialize a brand new heap
     (discarding the old one), as it will be called once for each test.
     Therefore, be sure to *initialize all your variables* here! */
}

/* Allocate a block of memory of the given size, or NULL if unable. 
   Returns: a pointer aligned to 8 bytes, or NULL if allocation failed. */
void *mymalloc(int size) {
  /* This is a dumb implementation of malloc, that does NOT reuse freed memory 
     You will augment this solution to make a real malloc. */

  /* Round `size` up to a multiple of 8 bytes */
  /* TODO: Make room for any extra metadata you need to store as part of the allocation */
  size = (size + 7) / 8 * 8;

  /* TODO: Walk through your free list to see if there is a freed block big enough
     to accommodate this allocation.  If so, remove that block from the free list and 
     return it to the caller, instead of allocating a new block from the current heap 'top'. */

  /* NOTE: The rest of this code should only execute if there is nothing on the freelist 
     we can use to satisfy this allocation request. */

  if (size < 0 || size > heapsize || heapsize - size < top) {
    /* There is not enough room in the heap - fail */
    return NULL;
  } else {
    /* Allocate the memory from `top` to `top+size` and return it */
    void *res = &heap[top];
    top += size;
    return res;
  }
}

/* Free the given block of memory. */
void myfree(void *ptr) {
  /* TODO: Our dumb implementation does not allow for any freeing. Implement me! */
}
