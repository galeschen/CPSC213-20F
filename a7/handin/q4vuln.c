#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

struct string {
  int len;
  char *str;
};

struct string str1 = {30, "Welcome! Please enter a name:"};
struct string str2 = {11, "Good luck, "};
struct string str3 = {43, "The secret phrase is \"squeamish ossifrage\""};

void print(struct string *str) {
  write(1, str->str, str->len);
}

void proof() {
  write(1, str3.str, str3.len);
}

void main() {
  char buf[128];
  struct string str4 = {128, buf};
  print(&str1);
  read(0, buf, 128);
  print(&str2);
  print(&str4);
}