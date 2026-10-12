function chezmoi-uv-diff --description "Diff installed uv tools against this host's chezmoi manifest"
    set -l installed (uv tool list | string match -rv '^-' | string replace -r ' .*' '' | sort -u)
    # Manifest lines hold full install arguments; the package is the last word, minus extras.
    set -l listed (chezmoi execute-template '{{ includeTemplate "uv-tools.txt" . }}' | string match -rv '^\s*$' | string replace -r '.*\s' '' | string replace -r '\[.*' '' | sort -u)

    echo "Installed but not in manifest:"
    comm -23 (printf '%s\n' $installed | psub) (printf '%s\n' $listed | psub) | sed 's/^/    /'
    echo
    echo "In manifest but not installed:"
    comm -13 (printf '%s\n' $installed | psub) (printf '%s\n' $listed | psub) | sed 's/^/    /'
end
