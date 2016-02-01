/// Handeling received packets.

var buffer = argument[0];
var msgid = buffer_read(buffer, buffer_u8);

switch(msgid) {
    case 1: // Ping.
        var time = buffer_read(buffer, buffer_u32);
        obj_client.ping = current_time - time;
        break;

    case 2: // Create hub.
        src_create_hub(buffer);
        break;
    
    case 3: // Created main hub.
        src_create_main_hub(buffer);
        break;
    
    case 4: // Make ready to set up game.
        room_goto_next(); // Go to game room.
        obj_client.players_amount = buffer_read(buffer, buffer_u8);
        obj_client.player_id = buffer_read(buffer, buffer_u8);
        instance_create(0, 0, obj_field);
        obj_field.map_size = buffer_read(buffer, buffer_u32);
        src_send_ready(); // Tell server client is ready.
        break;
        
    case 5: // Start game.
        show_message("Game starts.");
        break;
}
