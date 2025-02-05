" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

function! JuliaSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "_lines.r")
    call VimCmdLineSendCmd('include("' . g:cmdline_tmp_dir . '_lines.r")')
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "R"
let b:cmdline_quit_cmd = "quit(save=\"no\")"
let b:cmdline_source_fun = function("JuliaSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "r"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "_lines.r")'

call VimCmdLineSetApp("R")
