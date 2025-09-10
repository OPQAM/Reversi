# Notes

We'll want to OR our flags, in order to use more than one. To do that, we need to consult the docs and use O_CREATE (0100 - octal) + O_WRONGLY (0001 - octal). So 0101. We can write that as 101o (101 octal).


