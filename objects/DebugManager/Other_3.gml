/// @description Insert description here
// You can write your code in this editor
ini_open("Debug.ini");
ini_write_real("Debug", "a", a);
ini_write_real("Debug", "b", b);
ini_write_real("Debug", "c", c);
ini_write_real("Debug", "d", d);
ini_write_real("Debug", "e", e);
ini_close();
show_debug_message($"a:{a}\nb:{b}\nc:{c}\nd:{d}\ne:{e}");