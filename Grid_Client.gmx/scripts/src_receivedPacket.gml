/// Handeling received packets.

var buffer = argument[ 0 ];
var msgid = buffer_read( buffer , buffer_u8 );

switch( msgid ) {
    case 1: // Ping.
        var time = buffer_read( buffer , buffer_u32 );
        Ping = current_time - time;
        break;

    case 2: // Created hub.
        var hub_x = buffer_read( buffer , buffer_u32 );
        var hub_y = buffer_read( buffer , buffer_u32 );
        var hub_id = buffer_read( buffer , buffer_u32 );
         
        var new_hub = instance_create(hub_x, hub_y, obj_hub);
        new_hub.hub_id = hub_id;
        
        break;
}
