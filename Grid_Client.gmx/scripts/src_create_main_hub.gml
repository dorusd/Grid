/// Create a main hub.

var buffer = argument[0];

// Read from the buffer.
var hub_x = buffer_read(buffer, buffer_u32);
var hub_y = buffer_read(buffer, buffer_u32);
var hub_id = buffer_read(buffer, buffer_u32);
var hub_owner = chr(buffer_read(buffer, buffer_u32));

// Create main hub.
var new_hub = instance_create(hub_x, hub_y, obj_hub_main);
new_hub.hub_id = hub_id;
new_hub.owner = hub_owner;

// Set view to center on player's main hub.
if (hub_owner == obj_client.player_name) {
    view_xview[obj_player.cview] = hub_x - (view_wview[obj_player.cview] / 2);
    view_yview[obj_player.cview] = hub_y - (view_hview[obj_player.cview] / 2);
}
