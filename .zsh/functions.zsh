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
        ssh-add ~/.ssh/id_rsa
    elif [ -z $2 ]; then
        ssh-add ~/.ssh/$1/id_rsa
    else
        ssh-add ~/.ssh/$1/$2
    fi
}