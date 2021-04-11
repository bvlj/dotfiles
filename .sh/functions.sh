function ssh-set {
    # SSH keys organized like this:
    # .ssh
    # ├── aaaa
    # │   ├── id_rsa
    # │   └── id_rsa.pub
    # ├── bbbb
    # │   ├── id_dsa
    # │   ├── id_dsa.pub
    # │   ├── id_rsa
    # │   └── id_rsa.pub
    # ├── config
    # ├── id_rsa -> aaaa/id_rsa
    # ├── known_hosts
    # └── zzzz
    #     ├── id_rsa
    #     └── id_rsa.pub
    ssh-add -D
    if [ -z $1 ]; then
        # Default key: $ ssh-set
        ssh-add ~/.ssh/id_rsa
    elif [ -z $2 ]; then
        # Specific account: $ ssh-set bbbb
        ssh-add ~/.ssh/$1/id_rsa
    else
        # Specific key: $ ssh-set bbbb id_dsa
        ssh-add ~/.ssh/$1/$2
    fi
}

function git-skip {
    for f in $@; do
        git update-index --assume-unchanged $f;
        git update-index --skip-worktree $f;
    done
}

function git-unskip {
    for f in $@; do
        git update-index --no-assume-unchanged $f;
        git update-index --no-skip-worktree $f;
    done
}

function play-music {
    if [ $(command -v mpd) ]; then
        if [ ! $(pgrep -x mpd) ]; then
             mpd ~/.mpd/mpd.conf
        fi
        ncmpcpp
    fi
}

function puniq {
    echo "$1" | tr : '\n' | nl | sort -u -k 2,2 | sort -n |
        cut -f 2- | tr '\n' : | sed -e 's/:$//' -e 's/^://'
}
