#!/usr/bin/env bash
set -e
set -x

# for completion file
install -d "${HOME}/.zsh/mycomp"

# my utilities
UTILDIR="${HOME}/program/utils"
install -d $UTILDIR

cd $UTILDIR
(git clone git@github.com:syohex/my-command-utilities.git && cd my-command-utilities && ./setup.sh)

# setting for zsh zaw
if [[ -d ${HOME}/.zsh/zaw ]]; then
    (cd "${HOME}/.zsh/zaw" && git pull --rebase origin master)
else
    (cd "${HOME}/.zsh" && git clone git://github.com/zsh-users/zaw.git)
fi
## Install 3rd party zaw source
(cd "${HOME}/.zsh/zaw/sources" && curl -O https://raw.github.com/syohex/zaw-git-directories/master/git-directories.zsh )
(cd "${HOME}/.zsh/zaw/sources" && curl -O https://raw.github.com/shibayu36/config-file/master/.zsh/zaw-sources/git-recent-branches.zsh)

# completion
MYCOMPDIR="${HOME}/.zsh/mycomp"
if [[ -d ${HOME}/.zsh/zsh-completions ]]; then
    (cd "${HOME}/.zsh/zsh-completions" && git pull --rebase origin master)
else
    (cd "${HOME}/.zsh" && git clone git://github.com/zsh-users/zsh-completions.git)
fi
