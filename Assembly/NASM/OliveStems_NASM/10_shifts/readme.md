# Some extra notes:

We can change a register to have a value we wish. Let's say for example that, instead of just shifting right, we ant to immediately afterwards shift left a few times. We could:

set $eax  = $eax << 3

And remember that shifting allows division and multiplication by 2.
