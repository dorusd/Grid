/// Script for sending get ready to all players.

var clientid = 0;
var socketid = 0;

// Make game start on all servers.
repeat(obj_server.players_amount) {
    // Create buffer.
    buffer_seek(Buffer, buffer_seek_start, 0);
    buffer_write(Buffer, buffer_u8, 4); // Action ID for get ready.
    buffer_write(Buffer, buffer_u8, obj_server.players_amount);    
    buffer_write(Buffer, buffer_u8, clientid);
    buffer_write(Buffer, buffer_u32, obj_server.map_size);

    // Send buffer trough socket.
    socketid = ds_list_find_value(obj_server.SocketList, clientid);
    network_send_packet(socketid, Buffer, buffer_tell(Buffer));
    clientid += 1;
}
