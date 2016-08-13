if exists("b:did_autoload_quick_ultisnips") || !exists("g:_uspy")
    finish
endif
let b:did_autoload_quick_ultisnips = 1

function! s:saveEdit()
    if exists("s:editCallback")
        call s:editCallback()
    endif
    se nomodified
endfunction

" open a buffer for edit snip, default text is context
" after the buffer save, call callback
function! quickUltiSnip#Edit(content, callback) range
    let s:editCallback = a:callback
    let bufnr = bufnr('\[QuickUltiSnip]')
    if bufnr == -1
        silent new +setl\ bt=acwrite\ noswapfile\ bh=hide\ ft=snippets [QuickUltiSnip]
        augroup QuickUltiSnipEdit
            au! * <buffer>
            au BufWriteCmd <buffer> call <SID>saveEdit()
        augroup END
    else
        exe 'silent sb ' . l:bufnr
    endif
    resize 10

    silent %d " clear old content
    if !empty(a:content)
        silent put! =a:content
        silent $d " delete last line
    endif
endfunction

function! s:saveRegister()
    call setreg(s:editRegister, getline(1,'$'), 'v')
endfunction

function! quickUltiSnip#EditRegister() range
    let s:editRegister = v:register
    call quickUltiSnip#Edit(getreg(), function("s:saveRegister"))
endfunction

" Paste Content
function! s:paste(content)
    if strlen(a:content) == 0
        return
    endif
    call UltiSnips#Anon(a:content)
endfunction

function! quickUltiSnip#Insert() range
    echo "Please Input Snip register: "
    let c = nr2char( getchar() )
    if c == '='
        let l:content = input('=', '', 'expression')
        let l:content = eval(l:content)
    else
        let l:content = getreg(c)
    endif
    call s:paste(l:content)
    return ""
endfunction

function! quickUltiSnip#Paste() range
    let r = getreg()
    call s:paste(r)
endfunction
