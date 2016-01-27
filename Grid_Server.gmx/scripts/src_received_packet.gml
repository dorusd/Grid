/// Handeling packets.

var buffer = argument[0];
var socket = argument[1];
var msgid = buffer_read(buffer, buffer_u8);
   
switch(msgid) {
    case 1: // Check Ping.
        src_send_ping(buffer, socket);
        break;
      
    case 2: // Create Hub.
        src_send_hub(buffer, socket);
        break;
        
    case 3: // Add name to player.
        obj_server.player_name[obj_server.playerID] = buffer_read(buffer, buffer_u32);
        obj_server.playerID += 1;
        break;
}
