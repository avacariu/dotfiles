if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
set -g fish_key_bindings fish_vi_key_bindings

bind --mode insert \cR history-pager
abbr --add ris tput reset
abbr --add sl ls

function last_history_item; echo $history[1]; end
abbr --add !! --position anywhere --function last_history_item

function fish_mode_prompt; end

function fish_prompt
    set -l display_status $status
    echo

    switch $fish_bind_mode
        case default
            set_color --bold red
            echo -n '[N] '
        case insert
            set_color --bold green
            echo -n '[I] '
        case replace_one
            set_color --bold green
            echo -n '[r] '
        case replace
            set_color --bold green
            echo -n '[R] '
        case visual
            set_color --bold brmagenta
            echo -n '[V] '
        case '*'
            set_color --bold red
            echo -n '[?] '
    end
    set_color normal

    # Virtual environment (assuming a function or variable like virtualenv_info exists in fish)
    # If you use 'virtualfish' for example, this might be 'virtual_env_prompt'
    # For a general venv, you might need a custom function.
    if set -q VIRTUAL_ENV
        echo -n "(" (basename "$VIRTUAL_ENV") ")"
    end

    set_color --bold brgreen
    echo -n "$USER"@"$hostname"
    set_color normal
    echo -n ":"
    set_color --bold blue
    echo -n (prompt_pwd)
    set_color normal

    # Git status
    # Fish has built-in git prompt support
    set_color --bold brgreen
    echo -n (fish_git_prompt)

    if [ $display_status -ne 0 ]
        set_color --bold red
        echo -n " [$display_status]"
    end

    echo
    set_color --bold magenta
    echo -n '$ '
    set_color normal
end

# we're adding it here because if you add universal variables they're resolved
# to absolute paths and those can differ between machines
fish_add_path -g ~/.local/bin ~/.cargo/bin

if type -q zoxide
    zoxide init fish | source
end
