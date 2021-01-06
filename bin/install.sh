#!/usr/bin/env bash

dot_dir="${HOME}/dotfiles"

function has() {
  type "$1" > /dev/null 2>&1
}

### check command
if ! has "git"; then
  echo "git required"
  exit 1
fi

### asdf setup {{{
echo -e "### Installing asdf..."
asdf_dir="${HOME}/.asdf"
if [ ! -d ${asdf_dir} ]; then
  git clone https://github.com/asdf-vm/asdf.git ${asdf_dir}
  cd ${asdf_dir}
  git checkout "$(git describe --abbrev=0 --tags)"
fi
. ${asdf_dir}/asdf.sh

echo -e "### Installing python..."
asdf plugin add python
asdf install python latest
asdf reshim python

# create symbolic link
cd ${dot_dir}
for f in .??*;
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue
  [[ "$f" == "README.md" ]] && continue
  [[ "$f" == "install.sh" ]] && continue

  ln -snf ${dot_dir}/"$f" ${HOME}/"$f"
  echo -e "### Installed $f"
done

### }}}
echo -e "### Finished..."

