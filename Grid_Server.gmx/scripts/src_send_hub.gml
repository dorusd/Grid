/// Send info new hub to all players.

var buffer = argument[0];
var socket = argument[1];

// Read hub details from buffer.
var hub_x = buffer_read(buffer, buffer_u32);
var hub_y = buffer_read(buffer, buffer_u32);
obj_server.hub_count += 1;
var hub_id = obj_server.hub_count;

// Create new buffer.
buffer_seek(Buffer, buffer_seek_start, 0);
// Write buffer.
buffer_write(Buffer, buffer_u8, 2); // Action ID of creating hub.
buffer_write(Buffer, buffer_u32, hub_x);
buffer_write(Buffer, buffer_u32, hub_y);
buffer_write(Buffer, buffer_u32, hub_id);

var clientid = 0;
var socketid = 0;

// Send to all players.
repeat(ds_list_size(obj_server.SocketList)) {
    socketid = ds_list_find_value(obj_server.SocketList, clientid);
    network_send_packet(socketid, Buffer, buffer_tell(Buffer));
    clientid += 1;
}
