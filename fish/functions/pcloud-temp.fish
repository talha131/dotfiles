function pcloud-temp --description 'alias pcloud-temp=rclone move to the pcloud/1temp'
    command rclone move $argv pcloud:1temp -P;
end

