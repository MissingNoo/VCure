//feather disable all
//Input defines the default profiles as a macro called 
//This macro is parsed when Input boots up and provides the baseline bindings for your game
//
//  Please edit this macro to meet the needs of your game!
//
//The root struct called __input_config_verbs() contains the names of each default profile
//Default profiles then contain the names of verbs. Each verb should be given a binding that is
//appropriate for the profile. You can create bindings by calling one of the input_binding_*()
//functions, such as input_binding_key() for keyboard keys and input_binding_mouse() for
//mouse buttons

return {
    
    keyboard_and_mouse:
    {
        up:    [input_binding_key(vk_up)],
        down:  [input_binding_key(vk_down)],
        left:  [input_binding_key(vk_left)],
        right: [input_binding_key(vk_right)],
        
        accept:  [input_binding_key(vk_enter), input_binding_key("Z")],
        cancel:  [input_binding_key("X")],
        action:  input_binding_key(vk_add),
        special: input_binding_key(vk_shift),
        house: input_binding_key(vk_home),
        
        //No aiming verbs since we use the mouse for that (see below for aiming verb examples)
        click: input_binding_mouse_button(mb_left),
        
        pause: input_binding_key(vk_escape),
    },
    
    gamepad:
    {
        up:    [input_binding_gamepad_axis(gp_axislv, true),  input_binding_gamepad_button(gp_padu)],
        down:  [input_binding_gamepad_axis(gp_axislv, false), input_binding_gamepad_button(gp_padd)],
        left:  [input_binding_gamepad_axis(gp_axislh, true),  input_binding_gamepad_button(gp_padl)],
        right: [input_binding_gamepad_axis(gp_axislh, false), input_binding_gamepad_button(gp_padr)],
        
        accept:  input_binding_gamepad_button(gp_face1),
        cancel:  input_binding_gamepad_button(gp_face2),
        action:  input_binding_gamepad_button(gp_face3),
        special: input_binding_gamepad_button(gp_face4),
        
        aim_up:    input_binding_gamepad_axis(gp_axisrv, true),
        aim_down:  input_binding_gamepad_axis(gp_axisrv, false),
        aim_left:  input_binding_gamepad_axis(gp_axisrh, true),
        aim_right: input_binding_gamepad_axis(gp_axisrh, false),
        shoot:     [input_binding_gamepad_button(gp_shoulderlb), input_binding_gamepad_button(gp_shoulderrb)],
        
        pause: input_binding_gamepad_button(gp_start),
    },
    
    touch:
    {
        up:    input_binding_virtual_button(),
        down:  input_binding_virtual_button(),
        left:  input_binding_virtual_button(),
        right: input_binding_virtual_button(),
        
        accept:  input_binding_virtual_button(),
        click:  input_binding_virtual_button(),
        cancel:  input_binding_virtual_button(),
        action:  input_binding_virtual_button(),
        special: input_binding_virtual_button(),
        house: input_binding_virtual_button(),
        
        pause: input_binding_virtual_button(),
    }
    
};