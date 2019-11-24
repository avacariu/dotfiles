# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

for f in ~/.bashrc.d/???-*.sh; do
    source "$f";
done

source ~/.local/bin/dotfiles/bashmarks/bashmarks.sh
source ~/.bashrc_local 2>/dev/null
