### History
# 履歴ファイルの保存先
HISTFILE=${HOME}/.zsh_history
# メモリに保存される履歴件数
HISTSIZE=1000
# 履歴ファイルに保存される履歴件数
SAVEHIST=100000
# 開始時刻、終了時刻を履歴ファイルに書き込む
setopt extended_history
# 重複したコマンドは記録しない
setopt hist_ignore_dups
# 補完時に履歴を自動的に展開
setopt hist_expand
# 余分な空白は詰めて記録
setopt hist_reduce_blanks
# シェルのプロセスで履歴を共有
setopt share_history

### Completion
# no beep
setopt no_beep

### Change directory
# ディレクトリ名だけで移動
setopt auto_cd
# cd 時に自動で push
setopt auto_pushd

