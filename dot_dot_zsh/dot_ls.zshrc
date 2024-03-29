if (( $+commands[exa] )) {
  alias ls="exa --binary --git --time-style iso"
  alias recent="exa --binary --git --time-style iso -snew"
} else {
  alias ls="ls --color=auto"
  alias recent="ls -rt"
}

alias lsa="ls -a"
alias lsl="ls -la"

# use -d to only show folders
# broot backend ignores the depth option
tree () {  # [-L <depth>] [-d] [<arg>...]
  emulate -L zsh
  rehash

  local cmd depth dirsonly
  if (( $+commands[broot] )) {
    while [[ $1 =~ '^-[Ld]$' ]] {
      if [[ $1 == -L ]] { shift 2 }
      if [[ $1 == -d ]] { dirsonly=-f; shift }
    }
    cmd=(broot -S $dirsonly -c ' pt')
  } elif (( $+commands[exa] )) {
    while [[ $1 =~ '^-[Ld]$' ]] {
      if [[ $1 == -L ]] { depth=(-L $2); shift 2 }
      if [[ $1 == -d ]] { dirsonly=-D; shift }
    }
    cmd=(exa -T -l --git $depth $dirsonly)
  } elif (( $+commands[tree] )) {
    cmd=(=tree -C)
  } else {
    print -rlu2 -- "tree, exa, or broot required"
    return 1
  }
  $cmd $@
}
