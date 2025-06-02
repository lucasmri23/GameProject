if (!keyboard_check(vk_escape)) {
    pressed_esc = false;
}
if (keyboard_check_pressed(vk_escape) && !pressed_esc) {
    global.pause = !global.pause;
    pressed_esc = true;
}