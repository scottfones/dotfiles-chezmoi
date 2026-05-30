function b0 --description "Set screen and keyboard brightness to 0"
    brightnessctl --device=intel_backlight set 0%
    brightnessctl --device=nvidia_0 set 0%
    brightnessctl --device=tpacpi::kbd_backlight set 0%
end
