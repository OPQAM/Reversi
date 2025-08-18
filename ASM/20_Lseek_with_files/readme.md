# Notes on lseek()

lseek(fd, offset, whence) changes the current file offset.

ld      --> file descriptor
offset  --> number of bytes to move
whence  --> reference point

It's a system call in unix/linux operating at the byte level and letting us move the file offset to a specific byte location.

In whence, we can have SEEK_SET, SEEK_CUR and SEEK_END

And note:
#define SEEK_SET	0	/* Seek from beginning of file.  */
#define SEEK_CUR	1	/* Seek from current position.  */
#define SEEK_END	2	/* Seek from end of file.  */
