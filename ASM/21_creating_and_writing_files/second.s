section .data
        pathname DB "/home/opqam/Playground/Reversi/ASM/21_creating_and_writing_files/test.txt", 0 
        toWrite DB "Hello, World!",0AH,0DH,"$"
section .text
global main

main:
        ; Open system call
        MOV eax,5
        MOV ebx,pathname
        MOV ecx,101o ; O_WRONGLY+O_CREATE (100+1)
        MOV edx,700o ; READ+WRITE+EXECUTE (400+200+100)
    ; So, open syscall + write and create + read+write+execute permissions
        INT 80h

        ; Write data into file
        MOV ebx,eax
        MOV eax,4 ; write syscall
        MOV ecx,toWrite
        MOV edx,16
        
        MOV eax,1
        MOV ebx,42
        INT 80h
