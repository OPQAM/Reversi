#include <stdio.h>
#include <unistd.h>
#include <sys/ptrace.h>
#include <stdlib.h>
#include <sys/time.h>

void anti_debugger() {
    // Anti-debugging: Check if the program is being traced using ptrace
    if (ptrace(PTRACE_TRACEME, 0, 0, 0) == -1) {
        printf("Debugger detected! Exiting...\n");
        exit(1);
    }

    // Optional: Timing check to detect debugger based on abnormal timing behavior
    struct timeval start, end;
    gettimeofday(&start, NULL);

    for (volatile int i = 0; i < 1000000; i++);  // dummy loop for timing delay

    gettimeofday(&end, NULL);
    long time_taken = (end.tv_sec - start.tv_sec) * 1000000 + (end.tv_usec - start.tv_usec);

    if (time_taken < 1000) {  // If the program runs too fast (likely under a debugger)
        printf("Debugger detected based on timing! Exiting...\n");
        exit(1);
    }
}

int main() {
    anti_debugger();  // Check if we're being debugged

    // Simple hello world
    printf("Hello, World!\n");

    return 0;
}

