function chezmoi-crates-diff --description "Diff installed crates against this host's chezmoi manifest"
    set -l installed (cargo install --list | string match -rv '^\s' | string replace -r ' .*' '' | sort -u)
    # fish is installed by its own chezmoi script, not the manifest.
    set -l listed (begin
            chezmoi execute-template '{{ includeTemplate "cargo-crates.txt" . }}' | string match -rv '^\s*$'
            echo fish
        end | sort -u)

    echo "Installed but not in manifest:"
    comm -23 (printf '%s\n' $installed | psub) (printf '%s\n' $listed | psub) | sed 's/^/    /'
    echo
    echo "In manifest but not installed:"
    comm -13 (printf '%s\n' $installed | psub) (printf '%s\n' $listed | psub) | sed 's/^/    /'
end
