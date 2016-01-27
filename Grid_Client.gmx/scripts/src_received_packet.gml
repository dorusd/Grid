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
    
    case 4: // Make game start
        obj_client.game_start = true;
        show_message("Game has started");
        break;
}
