function chrome-webgpu --wraps=google-chrome-unstable --description 'Launches chrome dev with webgpu support'
    prime-run google-chrome-unstable \
        --enable-features=Vulkan \
        --ozone-platform=x11 \
        $argv
end
