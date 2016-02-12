#!/usr/bin/bash

# dist path
dist='/proc/version'

# detect dist and install basic requirements vcs AND oscm (git and chef)

# get packman by dist
success=true
if /bin/grep -q 'centos' $dist; then
    packman='yum' 
elif grep -q 'ubuntu' $dist; then 
    packman='apt-get' 
else
    packaman=false
    success=false
    echo 'runner not valid for '`/bin/cat ${dist}`
fi

# install mandatory packs
if [ "$packman"!=false ]; then
    if [ -e /usr/bin/git ]; then 
        /bin/echo 'git already instaleld'
    else
        /bin/echo ${packman}' install -y git' && $packman install -y git
        if [ $?!=0 ]; then
            /bin/echo 'failed to install git'
            success=false
        fi
    fi

    if [ -e /usr/bin/chef-apply ]; then 
        /bin/echo 'chef already installed'
    else
        /bin/echo ${packman}' install -y chef' && $packman install -y chef
        if [ $?!=0 ]; then
            /bin/echo 'failed to install chef'
            success=false
        fi
    fi
fi


/bin/echo 'Main install status is '${success}
