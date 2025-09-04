#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <sys/ptrace.h>
#include <unistd.h>
#include <errno.h>

// Simple XOR encryption key
const unsigned char key[] = {0x89, 0x45, 0x67, 0x23};

// Encrypted password stored as hex values
const unsigned char encrypted[] = {0xEC, 0x24, 0x03, 0x46, 0xCF, 0x27, 0x12, 0x45, 0xFA, 0x34};

// Function to detect if the program is being traced (debugged)
int check_debugger() {
    if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) == -1) {
        if (errno == EPERM) {
            // If ptrace fails with EPERM, we're likely being debugged
            return 1;
        }
    }
    return 0;
}

// Function to add a slight delay, but not rely solely on this for anti-debugging
void delay_execution() {
    // Small loop to add some delay
    volatile int i;
    for(i = 0; i < 1000000; i++); 
}

// Improved decryption with obfuscation
void decrypt(const unsigned char *input, char *output, size_t len) {
    for(size_t i = 0; i < len; i++) {
        // Obfuscated XOR operation
        output[i] = input[i] ^ key[i % sizeof(key)];
    }
}

// A more complex password verification to confuse the debugger
int verify_password(const char *input) {
    if(strlen(input) != sizeof(encrypted)) {
        return 0;
    }

    char decrypted[sizeof(encrypted) + 1];
    decrypt(encrypted, decrypted, sizeof(encrypted));
    decrypted[sizeof(encrypted)] = '\0';

    int result = 0;
    for(size_t i = 0; i < sizeof(encrypted); i++) {
        result |= (input[i] ^ decrypted[i]);  // XOR-based comparison
    }
    
    // Further obfuscation: Mask result to hide the true result
    result &= 0xFF;
    return !result;
}

int main() {
    char input[256];
    
    // Initial check to detect debugger
    if(check_debugger()) {
        printf("Nice try! But I detected a debugger...\n");
        return 1;
    }
    
    printf("Welcome to Level 2 - Password Challenge\n");
    printf("Enter the password: ");
    
    fgets(input, sizeof(input), stdin);
    input[strcspn(input, "\n")] = 0; // Remove newline
    
    // Obfuscated delay to make stepping through slower
    delay_execution();
    
    if(verify_password(input)) {
        printf("Congratulations! You've found the correct password!\n");
        printf("Access granted to Level 3\n");
    } else {
        printf("Incorrect password. Try again!\n");
    }
    
    return 0;
}

