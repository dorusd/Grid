/// Script for sending info about main_hub to all clients.

main_hub_radius = 500;
main_hub_radian = 0;
radian_per_player = real((2 * pi) / obj_server.players_amount);

for (player = 0; player < obj_server.players_amount; player++) {
    // Create buffer.
    buffer_seek(Buffer, buffer_seek_start, 0);
    buffer_write(Buffer, buffer_u8, 3); // Action ID for main hub.
    
    // Determine hub ID.
    obj_server.hub_count += 1;
    hub_id = obj_server.hub_count;
    
    // Determine hub owner.
    hub_owner = obj_server.player_name[player];
    
    // Write on buffer.
    buffer_write(Buffer, buffer_u32, main_hub_radius);
    buffer_write(Buffer, buffer_f32, main_hub_radian);
    buffer_write(Buffer, buffer_u32, hub_id);
    buffer_write(Buffer, buffer_u32, hub_owner);
    
    clientid = 0;
    socketid = 0;
    
    // Send location of the main hub to all players.
    repeat(obj_server.players_amount) {
        // Send buffer trough socket.
        socketid = ds_list_find_value(obj_server.SocketList, clientid);
        network_send_packet(socketid, Buffer, buffer_tell(Buffer));
        clientid += 1;
    }
    
    // Add to the radian.
    main_hub_radian += radian_per_player;
}
