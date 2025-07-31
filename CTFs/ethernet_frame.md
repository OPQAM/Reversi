# Notes

Hex Dump > Raw Binary > strings to get ASCII strings > Locate base64 encoded in ASCII > Decode base64 > get flag

xxd -r -p original.txt > frame.bin
strings frame.bin > ascii.txt
echo "<base64_here>" | base64 --decode;

