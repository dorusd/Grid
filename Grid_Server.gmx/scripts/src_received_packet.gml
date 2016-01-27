/// Handeling packets.

var buffer = argument[0];
var socket = argument[1];
var msgid = buffer_read(buffer, buffer_u8);
   
switch( msgid ) {
    case 1: // Check Ping.
        var time = buffer_read(buffer, buffer_u32);
        buffer_seek(Buffer, buffer_seek_start, 0);
        buffer_write(Buffer, buffer_u8, 1); // Action ID of ping check.
        buffer_write(Buffer, buffer_u32, time);
        network_send_packet(socket, Buffer, buffer_tell(Buffer));
        break;
      
    case 2: // Create Hub.
        var hub_x = buffer_read(buffer, buffer_u32);
        var hub_y = buffer_read(buffer, buffer_u32);
        obj_server_data.hub_count += 1;
        var hub_id = obj_server_data.hub_count;
        
        // Send info to all other clients.
        buffer_seek(Buffer, buffer_seek_start, 0);
        buffer_write(Buffer, buffer_u8, 2); // Action ID of creating hub.
        buffer_write(Buffer, buffer_u32, hub_x);
        buffer_write(Buffer, buffer_u32, hub_y);
        buffer_write(Buffer, buffer_u32, hub_id);
        
        var clientid = 0;
        var socketid = 0;

        repeat(ds_list_size(obj_server.SocketList)) {
            socketid = ds_list_find_value(obj_server.SocketList, clientid);
            network_send_packet(socketid, Buffer, buffer_tell(Buffer));
            clientid += 1;
        }
        break;
        
    case 3: // Add name to player.
        obj_server_data.player_name[obj_server.playerID] = buffer_read(buffer, buffer_u32);
        obj_server.playerID += 1;
}
