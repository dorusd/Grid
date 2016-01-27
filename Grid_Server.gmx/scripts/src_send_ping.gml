/// Send time stamp back to player to calculate ping.

var buffer = argument[0];
var socket = argument[1];

var time = buffer_read(buffer, buffer_u32);

buffer_seek(Buffer, buffer_seek_start, 0);

buffer_write(Buffer, buffer_u8, 1); // Action ID of ping check.
buffer_write(Buffer, buffer_u32, time);

network_send_packet(socket, Buffer, buffer_tell(Buffer));
