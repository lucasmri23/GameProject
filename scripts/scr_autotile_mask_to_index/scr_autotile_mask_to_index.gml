function autotile_mask_to_index(mask) {
    var lut = [
        46,44,45,38,43,18,19,14,
        42,32,35,25,34,36,37,27,
        40,16,17,12,22, 6, 7, 2,
        28, 8, 9, 4,20,10,11, 3,
        41,30,31,24,21,26,23,15,
        39,13, 5, 1,33,29, 0,47
    ];
    if (mask >= 0 && mask < array_length(lut)) {
        return lut[mask];
    } else {
        show_debug_message("Máscara desconhecida: " + string(mask));
        return 47; // fallback
    }
}
