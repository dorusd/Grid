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
        src_send_ready(); // Tell server client is ready.
        break;
        
    case 5: // Start game.
        view_wport[obj_player.cview] = 1024;
        view_hport[obj_player.cview] = 768;
        show_message("Game starts.");
        break;
}
