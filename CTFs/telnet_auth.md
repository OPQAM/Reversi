# Notes

Again I used wireshark, but this time I followed the TCP stream. The password was fun. In a stupid kind of way.

Noted that Telnet keystrokes by the user came each i their own packet.

Apparently this is character mode (raw/immediate mode) ---> The default for real-time input.

There is also line mode, where keystrokes are buffered locally by the client. Only when return is pressed does the client sent the entire line.

Telnet uses negotiation options (IAC WILL/WONT/DO/DONT) when the connection starts.
