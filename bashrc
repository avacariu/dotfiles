# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

for f in ~/.bashrc.d/*; do
    source "$f";
done

source ~/.local/bin/bashmarks/bashmarks.sh
source ~/.bashrc_local 2>/dev/null
