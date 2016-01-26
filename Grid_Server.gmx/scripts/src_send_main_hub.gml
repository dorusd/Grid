/// Script for sending info about main_hub to all clients.

main_hub_radius = 500;
main_hub_radian = 0;
radian_per_player = real((2 * pi) / (ds_list_size(obj_server.SocketList)));

repeat(ds_list_size(obj_server.SocketList)) {
    // Create buffer.
    buffer_seek(Buffer, buffer_seek_start, 0);
    buffer_write(Buffer, buffer_u8, 3); // Action ID for main hub.
    
    //  Determine hub location.
    hub_x = (sin(main_hub_radian) * main_hub_radius) + (obj_server_data.map_size / 2);
    hub_y = (cos(main_hub_radian) * main_hub_radius) + (obj_server_data.map_size / 2);
    
    // Determine hub ID.
    obj_server_data.hub_count += 1;
    hub_id = obj_server_data.hub_count;
    
    // Write on buffer.
    buffer_write(Buffer, buffer_u32, hub_x);
    buffer_write(Buffer, buffer_u32, hub_y);
    buffer_write(Buffer, buffer_u32, hub_id);
    
    clientid = 0;
    socketid = 0;
    
    // Send location of the main hub to all players.
    repeat(ds_list_size(obj_server.SocketList)) {
        // Send buffer trough socket.
        socketid = ds_list_find_value( obj_server.SocketList , clientid );
        network_send_packet( socketid , Buffer , buffer_tell( Buffer) );
        clientid += 1;
    }
    
    // Add to the radian.
    main_hub_radian += radian_per_player;
}