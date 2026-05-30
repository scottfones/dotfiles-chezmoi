function b1 --description "Set screen brightness to max, keyboard to 50%"
    brightnessctl --device=intel_backlight set 100%
    brightnessctl --device=nvidia_0 set 100%
    brightnessctl --device=tpacpi::kbd_backlight set 50%
end
