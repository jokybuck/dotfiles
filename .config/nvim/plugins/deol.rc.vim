let s:deol_win_width_percent = 0.85
let s:deol_win_height_percent = 0.7

function s:open_deol() abort
  let winwidth = float2nr(&columns * s:deol_win_width_percent)
  let wincol = float2nr((&columns - (&columns * s:deol_win_width_percent))/ 2)
  let winheight = float2nr(&lines * s:deol_win_height_percent)
  let winrow = float2nr((&lines - (&lines * s:deol_win_height_percent))/ 2)
  execute 'Deol -split=floating -winwidth=' . winwidth '-winheight=' . winheight '-winrow=' . winrow '-wincol=' . wincol
endfunction

nnoremap <silent> <Leader>s :<C-u>call <SID>open_deol()<CR>
tnoremap <ESC> <C-\><C-n>
