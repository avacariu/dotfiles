bd() {
    local newdir
    if [[ -z $1 ]]; then
        cd /
        return
    else
        newdir=$(dirname "$(pwd)")
    fi

    while [[ $(basename "$newdir") != *$1* ]] && [[ $(basename "$newdir") != "/" ]]; do
        newdir=$(dirname "$newdir")
    done

    if [[ $newdir == "/" ]]; then
        echo "No directory containing '$1' found."
    else
        echo "$newdir"
        cd "$newdir"
    fi
}

mkd() {
    mkdir "$1" && cd "$1"
}

numfiles() {
    for dir in "$@"; do
        /bin/echo -e "$(find -L "$dir" -type f | wc -l) \t $dir"
    done | sort -h --reverse
}

new() {
    cp "$HOME/Templates/$1" "$2"
}

_new-complete() {
    IFS=$'\n' tmp=( $(compgen -W "$(ls "$HOME/Templates/")" -- "${COMP_WORDS[$COMP_CWORD]}" ))
    COMPREPLY=( "${tmp[@]// /\ }" )
}
complete -F _new-complete new

encrypt() {
    openssl enc -aes256 -pass pass:"$1" -in "$2" -out "$2".encrypted
}

decrypt() {
    openssl enc -d -aes256 -pass pass:"$1" -in "$2" -out "$2".decrypted
}

print-tmux-colors() {
    for i in {0..255} ; do
        printf "\e[48;5;%sm    \e[0m \e[38;5;%smcolour \e[1m%s\n" "$i" "$i" "$i"
    done
}

printcol() {
    awk "${@:2}" -- "{ print \$${1} }"
}

myip4() {
    dig +short myip.opendns.com @resolver1.opendns.com
}

myip6() {
    ip -o -6 address show  scope global temporary | \
        awk '{ print $4 }' | \
        cut -d/ -f1
}


start-ssh-agent() {
    if [ -z "$SSH_AUTH_SOCK" ] ; then
        eval "$(ssh-agent -s)"
        ssh-add
    fi
}

kill-ssh-agent() {
    if [ -n "$SSH_AUTH_SOCK" ] ; then
        eval "$(/usr/bin/ssh-agent -k)"
    fi
}

new-venv() {
    if [[ -n $1 ]]; then
        python_ver=$1
    else
        python_ver=python3
    fi

    if [[ -d venv ]]; then
        echo "./venv/ already exists!"
        return 1
    fi

    $python_ver -m venv venv
    source venv/bin/activate
}

tmp-venv() {
    if [[ -n $1 ]]; then
        python_ver=$1
    else
        python_ver=python3
    fi

    tmpdir=$(mktemp -d --suffix=.venv)
    $python_ver -m venv "$tmpdir"
    source "$tmpdir/bin/activate"
}

update-keepassrpc() {
    curl -s https://api.github.com/repos/kee-org/keepassrpc/releases/latest | \
        jq -r ".assets[] | select(.name | test(\"KeePassRPC.plgx\")) | .browser_download_url" | \
        xargs sudo curl -s -L -o "/usr/lib/keepass2/plugins/KeePassRPC.plgx"
}

jn() {
    local journal_filepath
    local cur_date

    mkdir -p ~/Documents/journal/{day,topic}

    if [[ $1 = "topic" ]]; then
        cur_date="$(date '+%Y-%m-%d %A')"
        journal_filepath=~/Documents/journal/topic/"$2".md

        vim "+normal Go - ($cur_date) " +startinsert! "$journal_filepath"
    else
        cur_date="$(date '+%Y-%m-%d %A' --date="$*")"
        journal_filepath=~/Documents/journal/day/"$cur_date".md
        vim "+normal Go" +startinsert "$journal_filepath"
    fi
}

get-gitignore() {
    curl "https://www.gitignore.io/api/c%2Cvim%2Cpython" > .gitignore
}

new-repo() {
    local name="$1";

    if [[ -d $name ]]; then
        echo "Directory '$name' already exists!"
        return 1
    fi

    if [[ -z $name ]]; then
        echo "Need to specify a repo name"
        return 2
    fi


    mkdir "$name"
    cd "$name"
    git init
    get-gitignore

    echo "# $name" >> README.md

    git status
}

dirhash() {
    find $1 -type f -print0 | sort -z | xargs -0 cat | sha1sum;
}

dirhash2() {
    find $1 -type f -print0 | sort -z | xargs -0 sha1sum | sha1sum;
}

pyserve() {
    python3 -m http.server $@
}

# credit: https://stackoverflow.com/a/20026992
function virtualenv_info() {
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    [[ -n "$venv" ]] && echo "($venv) "
}
