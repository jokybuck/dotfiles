#!/usr/bin/env bash

set -e

dot_dir="${HOME}/dotfiles"

function has() {
  type "$1" > /dev/null 2>&1
}

### check command
if ! has "git" || ! has "curl"; then
  echo "git required"
  exit 1
fi

### Install pyenv & pyenv-virtualenv
if ! has "pyenv"; then
  echo -e "### Installing pyevn & pyenv-virtualenv"
  curl https://pyenv.run | bash
  export PATH="${HOME}/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

PYTHON3_VERSION="3.9.1"
if pyenv versions | grep -x "  ${PYTHON3_VERSION}" >/dev/null; then
  echo -e "### Skip python installation"
else
  echo -e "### Installing python"
  pyenv install ${PYTHON3_VERSION}
fi

VERTUALENV_NAME="neovim3"
echo -e "### Making virtualenv"
if pyenv virtualenvs | grep -x "  ${VERTUALENV_NAME}" >/dev/null; then
  pyenv uninstall ${VERTUALENV_NAME}
fi
pyenv virtualenv ${PYTHON3_VERSION} ${VERTUALENV_NAME}
pyenv activate ${VERTUALENV_NAME}
python --version
python -m pip install pynvim
pyenv deactivate ${VERTUALENV_NAME}

# create symbolic link
cd "${dot_dir}"
for f in .??*;
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".github" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue
  [[ "$f" == "README.md" ]] && continue
  [[ "$f" == "install.sh" ]] && continue

  ln -snf "${dot_dir}"/"$f" "${HOME}"/"$f"
  echo -e "### Installed $f"
done

### }}}
echo -e "### Finished..."

