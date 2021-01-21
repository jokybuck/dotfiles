" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {}

" Rust
if executable('rustup')
  let g:LanguageClient_serverCommands['rust'] = ['rustup', 'run', 'stable', 'rls']
endif

" TypeScript
if executable('typescript-language-server')
  let g:LanguageClient_serverCommands['typescript'] = ['typescript-language-server', '--stdio']
endif
