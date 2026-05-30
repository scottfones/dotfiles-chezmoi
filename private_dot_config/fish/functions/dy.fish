function dy --wraps=dysk --description "List disks with labels and UUIDs"
    dysk -c label+default+uuid+partuuid -s size-a -a -f 'disk <> ""' $argv
end
