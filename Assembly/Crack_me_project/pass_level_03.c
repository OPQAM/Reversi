#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

// Simple XOR encryption key (obfuscated)
const unsigned char key[] = {0x89, 0x45, 0x67, 0x23};

// Encrypted password stored as hex values (obfuscated)
const unsigned char encrypted[] = {0xEC, 0x24, 0x03, 0x46, 0xCF, 0x27, 0x12, 0x45, 0xFA, 0x34};

// Obfuscation: function to "reveal" key and password at runtime
void reveal_data(unsigned char *key, unsigned char *encrypted, unsigned char *decrypted) {
    int i;
    for (i = 0; i < 10; i++) {
        decrypted[i] = encrypted[i] ^ key[i % 4]; // Simple XOR decryption
    }
}

// Dummy delay function to slow down execution (forces stepping)
void delay_execution() {
    volatile int i;
    for (i = 0; i < 100000000; i++) ;  // Intentional delay
}

// Function to simulate password verification
int verify_password(const char *input) {
    unsigned char decrypted[10];
    reveal_data((unsigned char *)key, (unsigned char *)encrypted, decrypted);
    
    if (strncmp(input, (char *)decrypted, 10) == 0) {
        return 1;
    }
    
    return 0;
}

int main() {
    char input[256];
    
    printf("Welcome to the Password Challenge\n");
    printf("Enter the password: ");
    
    fgets(input, sizeof(input), stdin);
    input[strcspn(input, "\n")] = 0;  // Remove newline

    // Obfuscated delay to make stepping through slower
    delay_execution();

    if (verify_password(input)) {
        printf("Congratulations! You've found the correct password!\n");
    } else {
        printf("Incorrect password. Try again!\n");
    }

    return 0;
}

