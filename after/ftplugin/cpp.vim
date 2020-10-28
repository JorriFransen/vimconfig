
set shiftwidth=4 tabstop=4 expandtab

setlocal path=.,,**

compiler cpp

function! Compile()
    exec "wa"

    " call quickfix#open()
    " silent make


    let g:asyncrun_open = 14
    AsyncRun echo ninja: Entering directory build&& cmake --build build
    redraw!
endfunction

