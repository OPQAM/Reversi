# These are Notes on ROOT-ME challenges

I don't know if I'll keep doing these. They are part of a challenge set up by a colleague at work. If I'm having fun, I'll keep them up, if not, no.

### Bash - System 1

Main idea:

- I have a file that has the password but which can only be read by root. I'm not root, ofc.

But there is a C program that was coded thusly:

    #include <stdlib.h>
    #include <sys/types.h>
    #include <unistd.h>

    int main(void)
    {
        setreuid(geteuid(), geteuid());
        system("ls /challenge/app-script/ch11/.passwd");
        return 0;
    }

If I run this file I'm doing it as root.
setreuid(geteuid(), geteuid()) is setting te user that runs the file as root.
So, what I want is not to do *ls* but instead do *cat* on the file.
That would do the trick.

To do that, I created my own version of ls and set it in the path.
When that is run, I only had to run the file. This gave me a root shell and I just had to run the file and get the password.

---
