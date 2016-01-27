// Add hub created by some player.

var buffer = argument[0];

// Read buffer.
var hub_x = buffer_read(buffer, buffer_u32);
var hub_y = buffer_read(buffer, buffer_u32);
var hub_id = buffer_read(buffer, buffer_u32);

// Create hub.
var new_hub = instance_create(hub_x, hub_y, obj_hub);
new_hub.hub_id = hub_id;
