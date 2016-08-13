if exists('did_plugin_quick_ultisnips') || &cp
    finish
endif
let did_plugin_quick_ultisnips=1

function! s:YankOperatorMap(type)
    if a:type ==# "line" | let mode = 'V'
    elseif a:type ==# "block" | let mode = ''
    else | let mode = 'v'
    endif

    exe 'normal! `['.mode.'`]"'.g:lastRegister."y"
    unlet g:lastRegister
    call quickUltiSnip#EditRegister()
endfunction

nnoremap <Plug>quickUltiSnipYankOperator :<C-U>let g:lastRegister=v:register<bar>set opfunc=<SID>YankOperatorMap<CR>g@
nnoremap <Plug>quickUltiSnipYankLineWise Y:call quickUltiSnip#EditRegister()<CR>
vnoremap <Plug>quickUltiSnipYankVisual y:call quickUltiSnip#EditRegister()<CR>
