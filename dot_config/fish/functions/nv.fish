function nv
    if $argv[1] != ""
        cd $argv[1]
    end
    neovide . && exit 1
end
