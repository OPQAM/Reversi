# Some Notes

When running gdb with arguments for the program we're analyzing, we need to do:

. gdb --args <my_program> <my_args>

Otherwise, gdb thinks that the args we inputed are its own arguments and not the program's.
