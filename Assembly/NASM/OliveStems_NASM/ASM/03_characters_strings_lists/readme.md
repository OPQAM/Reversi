'A' is stored as an ascii value, ofc.

- In the list 1,2,3,4 we add a -1 to know when the list actually ends. We signal ouselves with a null terminator, that the list has in fact reached an end - this way we can check when it finally ends when debugging. We could also have added a 0 at the end.

- data deals with characters, data2 deals with lists and data3 deals with strings

- Again, notice that in data3, when we're dealing with strings, we also need a null terminator. But with strings is easier than with lists of numbers. In this case, after our string, we just add a ,0 and thus ad a null terminator to our string.
