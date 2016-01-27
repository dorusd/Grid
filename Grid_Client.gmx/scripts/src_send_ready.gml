/// Tell network client is ready to start the game.

// Send ready.
buffer_seek(obj_client.Buffer, buffer_seek_start, 0);
buffer_write(obj_client.Buffer, buffer_u8, 4); // Id of action.
network_send_packet(obj_client.Socket, obj_client.Buffer, buffer_tell(obj_client.Buffer));
