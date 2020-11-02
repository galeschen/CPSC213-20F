#include <stdlib.h>
#include <stdio.h>
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
// metadata is a node in our linked list
struct metadata
{
   int size;              // size of current block, 4 bytes
   struct metadata *next; // pointer to next block of free memory 8 bytes
   // metadata is first 16 bytes of whole allocation
};
struct metadata *list_head;
struct metadata *current_data;
struct metadata* res;

/* Initialize your memory manager to manage the given heap. */
void mymalloc_init(char *_heap, int _heapsize)
{
   // printf("%s\n", "made it to mymalloc_init");
   heap = _heap;
   heapsize = _heapsize;
   top = 0;
   list_head = NULL;

   /* TODO: Any other initialization you want to do */
   /* NOTE! Each call to mymalloc_init should initialize a brand new heap
     (discarding the old one), as it will be called once for each test.
     Therefore, be sure to *initialize all your variables* here! */
}

void *mymalloc(int size) {
  /* This is a dumb implementation of malloc, that does NOT reuse freed memory 
     You will augment this solution to make a real malloc. */

  /* Round `size` up to a multiple of 8 bytes */
  /* TODO: Make room for any extra metadata you need to store as part of the allocation */
   if (size == 0) {
         size = 1;
      }
   size = (size + 7) / 8 * 8;
   size += sizeof(struct metadata);

  /* TODO: Walk through your free list to see if there is a freed block big enough
     to accommodate this allocation.  If so, remove that block from the free list and 
     return it to the caller, instead of allocating a new block from the current heap 'top'. */
   // printf("size: %d\n", size);
   if (list_head != NULL) {
      // printf("%s\n", "made it to mymalloc");
      struct metadata* prev = NULL;
      current_data = list_head;
      struct metadata* retval;

      while (current_data != NULL) {
         int counter = 0;
         // printf ("counter: %d\n", counter);
         // printf("current_data->size: %d\n", current_data->size);
         if (current_data->size >= size) {
            // if prev = null, then current data is head. all u have to do is set the next to head.
            if (prev == NULL) {
               list_head = current_data->next;
            }
            // if prev is not null, then current data is not head. this means that you have to set prev to be pointing to
            // current_data->next (ie. skip over current_data)
            if (prev != NULL) {
               prev->next = current_data->next;
            }
            // retval = ((void*) current_data + (sizeof(struct metadata)));
            retval = (void*) current_data + (sizeof(struct metadata));
            return retval;
         }
         prev = current_data;
         current_data = current_data->next;
         counter ++;
     }
   }

  /* NOTE: The rest of this code should only execute if there is nothing on the freelist 
     we can use to satisfy this allocation request. */
  if (size < 0 || size > heapsize || heapsize - size < top) {
    /* There is not enough room in the heap - fail */
    return NULL;
  } else {
    /* Allocate the memory from `top` to `top+size` and return it */
    res = (struct metadata*) &heap[top];
    res->next = NULL;
    res->size = size;
    top += size;
   //  printf("size: %d\n", size);
   //  printf ("res->size: %d\n", res->size);
   //  printf("top: %d\n", top);
   //  printf("res: %li\n" , res);
    // return ((void*) res + (sizeof(struct metadata)));
    return (void*) res + (sizeof(struct metadata));
  }
}

/* Free the given block of memory. */
void myfree(void *ptr)
{
   /* TODO: Our dumb implementation does not allow for any freeing. Implement me! */
   // printf("%s\n", "made it to myfree");
   // printf("ptr: %li\n", ptr);
   // printf("size of metadata: %d\n", sizeof(struct metadata));
   struct metadata* temp = ptr - (sizeof(struct metadata));
   temp->next = list_head;
   list_head = temp;
   // printf("temp->size: %d\n", temp->size);
}




// #include <stdlib.h>
// #include <stdio.h>
// #include "mymalloc.h"

// /* Feel free to change/remove these variables and/or add your own. */
// /* NOTE: The 'static' keyword makese these variables private to this file. 
//    If you leave it off, the variable is still static, of course, but it also
//    has global scope (can be accessed anywhere in the program).  Adding the 'static'
//    keyword changes the variables to have "file" scope. */

// // Base address of the allocated heap.
// static char *heap;
// // Size of the complete heap.
// static int heapsize;
// // Next unallocated location in the heap.
// static int top;
// // metadata is a node in our linked list
// struct metadata
// {
//    int size;              // size of current block, 4 bytes
//    int marker;            // when allocated set to 1, when freed set to 0
//    // int* start;             // start address not including metadata (ie. the address u return when mymalloc is called.)
//    struct metadata *next; // pointer to next block of free memory 8 bytes
//    // metadata is first 16 bytes of whole allocation
// };
// struct metadata *list_head;
// struct metadata *current_data;

// /* Initialize your memory manager to manage the given heap. */
// void mymalloc_init(char *_heap, int _heapsize)
// {
//    printf("made it to mymalloc_init");
//    heap = _heap;
//    heapsize = _heapsize;
//    top = 0;
//    // where does head go?
//    list_head = NULL;

//    /* TODO: Any other initialization you want to do */
//    /* NOTE! Each call to mymalloc_init should initialize a brand new heap
//      (discarding the old one), as it will be called once for each test.
//      Therefore, be sure to *initialize all your variables* here! */
// }

// /* Allocate a block of memory of the given size, or NULL if unable. 
//    Returns: a pointer aligned to 8 bytes, or NULL if allocation failed. */
// void *mymalloc(int size)
// {
//    printf("made it to mymalloc");
//    /* This is a dumb implementation of malloc, that does NOT reuse freed memory 
//      You will augment this solution to make a real malloc. */

//    /* Round `size` up to a multiple of 8 bytes */
//    /* TODO: Make room for any extra metadata you need to store as part of the allocation */
//    if (size == 0)
//    {
//       size = 1;
//    }
//    size = (size + 7) / 8 * 8;
//    size += sizeof(struct metadata);
//    // need to add 8 to size to make space of metadata (metadata stores size of block)

//    /* TODO: Walk through your free list to see if there is a freed block big enough
//      to accommodate this allocation.  If so, remove that block from the free list and 
//      return it to the caller, instead of allocating a new block from the current heap 'top'. */
//    if (list_head == NULL)
//    {
//       /* Allocate the memory from `top` to `top+size` and return it */
//       top += size;
//       // add res to the end of the linked list.
//       struct metadata *res;
//       res = (struct metadata *)&heap[top];
//       // set res's size to the size of the requested block + metadata, and set res marker to 1 b/c it's allocated...?
//       res->size = size;
//       res->marker = 1;
//       // res->start = (void *)res + (sizeof(struct metadata));
//       return (void *)res + (sizeof(struct metadata));
//    }

//    current_data = list_head;
//    struct metadata *prev = NULL;
//    while (current_data != NULL)
//    {
//       // if you find a node that is the right size and is free...
//       if (current_data->size >= size & current_data->marker == 0)
//       {
//          // set marker to allocated/1
//          current_data->marker = 1;
//          // return that block of memory.
//          return (void *)current_data + sizeof(struct metadata);
//       }
//       prev = current_data;
//       if (current_data->next != NULL)
//       {
//          current_data = current_data->next;
//       }
//    }

//    /* NOTE: The rest of this code should only execute if there is nothing on the freelist 
//      we can use to satisfy this allocation request. */

//    if (size < 0 || size > heapsize || heapsize - size < top)
//    {
//       /* There is not enough room in the heap - fail */
//       return NULL;
//    }
//    else
//    {
//       /* Allocate the memory from `top` to `top+size` and return it */
//       top += size;
//       // add res to the end of the linked list.
//       struct metadata *res;
//       res = (struct metadata *)&heap[top];
//       // set res's size to the size of the requested block + metadata, and set res marker to 1 b/c it's allocated...?
//       res->size = size;
//       res->marker = 1;
//       return (void *)res + (sizeof(struct metadata));
//    }
// }

// /* Free the given block of memory. */
// void myfree(void *ptr)
// {
//    /* TODO: Our dumb implementation does not allow for any freeing. Implement me! */
//    printf("made it to myfree");
//    // if list is empty, there is nothing to free.
//    if (list_head == NULL)
//    {
//       return;
//    }
//    struct metadata *temp = ptr - (sizeof(struct metadata));
   
//    // set temp to metadata
//    // add metadata to list of free data
//    // then mark the marker as 0

//    struct metadata *temp = ptr - (sizeof(struct metadata));
//    current_data = list_head;
//    struct metadata *prev = NULL;
//    while (current_data != NULL)
//    {
//       // start address of metada - 
//       long current_start_address = &(current_data) - (sizeof(struct metadata));
//       long wanted_address = temp;
//       if (current_data->marker == 1)
//       {
//          temp->marker = 0;
//          temp->next = list_head;
//          list_head = temp;
//       }
//       prev = current_data;
//       if (current_data->next != NULL)
//       {
//          current_data = current_data->next;
//       }
//    }
//    printf("made it to end of myfree");
// }
