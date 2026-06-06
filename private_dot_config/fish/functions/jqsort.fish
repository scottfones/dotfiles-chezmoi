function jqsort --description 'Alpha-sort a JSON file by key with jq -S'
    if not set -q argv[1]
        echo 'jqsort: usage: jqsort INPUT [OUTPUT]' >&2
        return 2
    end

    set -l input $argv[1]
    set -l output $input
    set -q argv[2]; and set output $argv[2]

    set -l tmp (mktemp)
    if jq -S . $input >$tmp
        mv -- $tmp $output
    else
        rm -f -- $tmp
        echo "jqsort: failed to sort '$input'" >&2
        return 1
    end
end
