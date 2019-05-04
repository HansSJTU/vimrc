source /usr/share/vim/google/google.vim
source /usr/share/vim/google/gtags.vim
" source /google/data/ro/projects/vigor/vigor.vim

" === Plugin ===
Glug gtimporter
Glug syntastic-google
Glug critique
Glug corpweb
Glaive autogen !plugin[autocmds]
" ===============

au User lsp_setup call lsp#register_server({
    \ 'name': 'Kythe Language Server',
    \ 'cmd': {server_info->['/google/bin/releases/grok/tools/kythe_languageserver', '--google3']},
    \ 'whitelist': ['python', 'go', 'java', 'cpp', 'proto'],
    \})
nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>

command Jade !/google/data/ro/teams/jade/jadep % 

function! GenerateDataPol()
    let s:line=getline('.')
    if s:line !~ "[" && s:line !~ "(" && s:line !~ ")"
        if s:line !~ ";"
            echo "Please use this shortcut at last line of adding!"
        else
            call feedkeys("$i [(datapol.semantic_type) = ST_NOT_REQUIRED]\<esc>")
        endif
    elseif s:line =~ "]"
        call feedkeys("$hi,\<cr>(datapol.semantic_type) = ST_NOT_REQUIRED\<esc>")
    elseif s:line =~ "(" 
        call feedkeys("$a,\<cr>(datapol.semantic_type) = ST_NOT_REQUIRED\<esc>")
    else
        echo "Not supported line. Ask Hanxiao to add support."
    endif
endfunction

" datapol annotation
nnoremap <leader>1 iimport "storage/datapol/annotations/proto/semantic_annotations.proto";<cr><cr>option (datapol.file_vetting_status) = "latest";<esc>
nnoremap <leader>2 :call GenerateDataPol()<cr>
nnoremap <leader>3 $A<cr>"//storage/datapol/annotations/proto:datapol_annotations",<esc>
