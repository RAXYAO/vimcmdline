" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif
if exists('*AMPLSourceLines')
    finish
endif
silent function! AMPLSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.run")
    call VimCmdLineSendCmd('include "' . g:cmdline_tmp_dir . '/lines.run"')
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "ampl"
let b:cmdline_quit_cmd = "exit;"
let b:cmdline_source_fun = function("AMPLSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "ampl"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.run")'

call VimCmdLineSetApp("ampl")
