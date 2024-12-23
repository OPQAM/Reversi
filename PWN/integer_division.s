.intel_syntax noprefix
.global _start

_start:

# speed = distance / time
# distance = rdi
# time = rsi

        xor rdx, rdx       # Make rdx = 0. We only need 64 bytes
        mov rax, rdi       # We moved distance to the dividend
        div rsi            # rax has speed now

        # mov rdi, 42             # the exit code
        # mov rax, 60               # exit syscall
        # syscall

# NOTES:
#
# rdx are the higher 64 bits and rax the lower 64 bits of the dividend.
# In this case, since the number we were using in the dividend was smaller
# than 64 bits, then we didn't need the rdx part, and so we zeroed it
# running div makes the division and stores the result inside rax
# So rax has the speed and that is the final solution.
# This exercise didn't require an exit code + syscall
# Important:
# In a division, rdx hold the higher bits and rax the lower (dividend)
# rdi holds the divisor, and after we invoke div rax will hold the quotient
# and rdx holds the remainder.
