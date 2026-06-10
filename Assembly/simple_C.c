#include <stdio.h>
#include <string.h>

int check(const char *s) {
if (strlen(s) != 5) return 0;
if ((s[0] ^ 0x12) != 'A') return 0;
if ((s[1] + 3) != 'k') return 0;
if ((s[2] - 1) != '7') return 0;
if ((s[3] ^ s[4]) != 0x5) return 0;
return 1;
}

int main(int argc, char **argv) {
if (argc != 2) {
puts("usage");
return 1;
}
if (check(argv[1])) puts("ok");
else puts("no");
}
