/// Script for sending start message to all players.

// Create buffer.
buffer_seek( Buffer , buffer_seek_start , 0 );
buffer_write( Buffer, buffer_u8 , 4 ); // Action ID for game start.

var clientid = 0;
var socketid = 0;

// Make game start on all servers.
repeat(ds_list_size(obj_server.SocketList)) {
    // Send buffer trough socket.
    socketid = ds_list_find_value( obj_server.SocketList , clientid );
    network_send_packet( socketid , Buffer , buffer_tell( Buffer) );
    clientid += 1;
}
