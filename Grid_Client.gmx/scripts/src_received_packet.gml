/// Handeling received packets.

var buffer = argument[0];
var msgid = buffer_read(buffer, buffer_u8);

switch(msgid) {
    case 1: // Ping.
        var time = buffer_read(buffer, buffer_u32);
        Ping = current_time - time;
        break;

    case 2: // Created hub.
        var hub_x = buffer_read(buffer, buffer_u32);
        var hub_y = buffer_read(buffer, buffer_u32);
        var hub_id = buffer_read(buffer, buffer_u32);
         
        var new_hub = instance_create(hub_x, hub_y, obj_hub);
        new_hub.hub_id = hub_id;
        
        break;
    
    case 3: // Created main hub.
        var hub_x = buffer_read(buffer, buffer_u32);
        var hub_y = buffer_read(buffer, buffer_u32);
        var hub_id = buffer_read(buffer, buffer_u32);
        var hub_owner = chr(buffer_read(buffer, buffer_u32));
         
        var new_hub = instance_create(hub_x, hub_y, obj_hub_main);
        new_hub.hub_id = hub_id;
        new_hub.owner = hub_owner;
        
        // Set view to center on player's main hub.
        break;
    
    case 4: // Make game start
        obj_client.game_start = true;
        show_message("Game has started");
        
        break;
}
