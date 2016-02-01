/// Create a main hub.

var buffer = argument[0];

// Read from the buffer.
var main_hub_radius = buffer_read(buffer, buffer_u32);
var main_hub_radian = buffer_read(buffer, buffer_f32) + obj_field.radian_offset;
var hub_id = buffer_read(buffer, buffer_u32);
var hub_owner = chr(buffer_read(buffer, buffer_u32));

//  Determine hub location.
hub_x = (sin(main_hub_radian) * main_hub_radius) + (obj_field.map_size / 2);
hub_y = (cos(main_hub_radian) * main_hub_radius) + (obj_field.map_size / 2);

// Create main hub.
var new_hub = instance_create(hub_x, hub_y, obj_hub_main);
new_hub.hub_id = hub_id;
new_hub.owner = hub_owner;

// Set view to center on player's main hub.
if (hub_owner == obj_client.player_name) {
    view_xview[obj_player.cview] = hub_x - (view_wview[obj_player.cview] / 2);
    view_yview[obj_player.cview] = hub_y - (view_hview[obj_player.cview] / 2);
    
    var center_x = view_xview[obj_player.cview] + (view_wview[obj_player.cview] / 2);
    var bottom = view_yview[obj_player.cview] + view_hview[obj_player.cview];

    obj_stats_box.x = center_x - 300;
    obj_stats_box.y = bottom - 170;
}
