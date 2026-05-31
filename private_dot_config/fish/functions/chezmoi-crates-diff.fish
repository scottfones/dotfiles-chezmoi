function chezmoi-crates-diff --description "Diff installed crates against chezmoi manifest"
    set -l manifest (chezmoi source-path)/.chezmoitemplates/cargo-crates.txt
    if not test -f $manifest
        echo "cargo-crates manifest not found: $manifest" >&2
        return 1
    end

    set -l installed (cargo install --list | grep -E '^[^[:space:]]' | sed 's/ .*//' | sort -u)
    set -l listed (grep -vE '^[[:space:]]*$' $manifest | sort -u)

    echo "Installed but not in manifest:"
    comm -23 (printf '%s\n' $installed | psub) (printf '%s\n' $listed | psub) | sed 's/^/    /'
    echo
    echo "In manifest but not installed:"
    comm -13 (printf '%s\n' $installed | psub) (printf '%s\n' $listed | psub) | sed 's/^/    /'
end
