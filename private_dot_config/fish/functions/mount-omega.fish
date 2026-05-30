function mount-omega --wraps=sshfs --description 'Mount omega drives via sshfs'
    sshfs scott@omega:/mnt/videos/movie /home/scott/Remote/Omega/Movies
    sshfs scott@omega:/mnt/videos/tv /home/scott/Remote/Omega/TV
    sshfs scott@omega:/mnt/videos/_tmp /home/scott/Remote/Omega/_tmp
end
