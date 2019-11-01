" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif
if exists('*LuaSourceLines')
    finish
endif
silent function! LuaSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.lua")
    if a:lines[len(a:lines)-1] == ''
      call VimCmdLineSendCmd('. "'. join(a:lines, b:cmdline_nl))
    else
      call VimCmdLineSendCmd('dofile("' . g:cmdline_tmp_dir . '/lines.lua")')
    endif
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "lua"
let b:cmdline_quit_cmd = "os.exit()"
let b:cmdline_source_fun = function("LuaSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "lua"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.lua")'

call VimCmdLineSetApp("lua")
