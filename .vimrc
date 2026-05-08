" # paste
" - fixed format for Ctrl-v/Ctrl-Shift-v/Shift-Insert paste
" - ref: https://vi.stackexchange.com/questions/23110/pasting-text-on-vim-inside-tmux-breaks-indentation
let &t_BE = "\e[?2004h"
let &t_BD = "\e[?2004l"
exec "set t_PS=\e[200~"
exec "set t_PE=\e[201~"
" # keymap
let mapleader = ' '
nnoremap Q <nop>
nnoremap <C-a> <nop>
nnoremap <C-x> <nop>
nnoremap <Space> <nop>
vnoremap <Space> <nop>
nnoremap <C-l> :noh<CR>
inoremap <C-c> <Esc>
" - % refers to the current buffer
" - %:p refers to the path to the file
nnoremap <leader>b :exe "w %:p.bak.".strftime("%Y%m%d_%H%M%S")<CR>:echo "Backup:" . expand("%:p") . ".bak." . strftime("%Y%m%d_%H%M%S")<CR>
nnoremap <leader>c :%s/\s\+$//e<CR>:%s/\r$//e<CR>
vnoremap "*y y:<C-U>call YANK(@0)<CR>:echo "Yank"<CR>
nnoremap <leader>y :let @0 = expand("%:p")<CR>:let @" = @0<CR>:<C-U>call YANK(@0)<CR>:echo "Yank: " . getreg('@0')<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :GFiles<CR>
" :<C-f> edit in command mode
" <C-w>H/J/L/K window moving
" <C-w>f attach new window
" @@ command repeat
" ; keymap repeat
" , keymap reversely repeat
" :cr[ewind] quickfix list first item
" :cla[st] quickfix list last item
" - ref: https://www.youtube.com/watch?v=oQB8lYUZtrY
nnoremap [q :cp<CR>zz
nnoremap ]q :cn<CR>zz
nnoremap [Q :cpf<CR>zz
nnoremap ]Q :cnf<CR>zz
" get closed files
" browse old
" vert [number]
nnoremap X "_D
vnoremap X "_D
nnoremap x "_x
vnoremap x "_x
vnoremap p "_dP
vnoremap Y $y
vnoremap < <gv
vnoremap > >gv
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap G Gzz
nnoremap 'm 'mzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz
" # set
" - move to other file without saving file
set hidden
" - line
set nowrap
" - mouse
set mouse=a
" - fixed window flicker when redraw in powershell or command prompt
set lazyredraw
" - fixed cursor flicker when redraw in powershell or command prompt
set guicursor=
" - line count in virtual mode
set showcmd
" - status
" - ref: https://zhung.com.tw/article/install-and-start-vim-with-minimal-vimrc/
set laststatus=2
" - cursor
" - ref: https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>[6 q" "SI = INSERT mode
let &t_SR = "\<Esc>[4 q" "SR = REPLACE mode
let &t_EI = "\<Esc>[2 q" "EI = NORMAL mode (ELSE)
" - number
set number
set numberwidth=4
set relativenumber
" - fold
set foldmethod=marker
set foldmarker=#{{{,#}}}
" - display space
set list
set listchars=tab:>\ ,trail:·
" - conceal special symbol
set conceallevel=2
" - file
set undofile
set undodir=~/.vim/undodir
set nobackup
set noswapfile
" - tab
set tabstop=4
set shiftwidth=4
set expandtab
" - indent
set smartindent
" - search
set hlsearch
set incsearch
" - window
set scrolloff=8
set splitright
set splitbelow
" - newtrw
let g:netrw_banner = 0

" # insert mode abbreviation
" - Insert date at typing tds in insert mode
" - ref https://stackoverflow.com/a/22578234
iab <expr> _DS strftime("%Y-%m-%d %H:%M:%S")

" # autcocmd
" - disable auto comment on current current for every filetype
autocmd FileType * setlocal formatoptions-=cro

" # function
" ## YANK function
" - ref: https://sunaku.github.io/tmux-yank-osc52.html#configure-your-vimrc
function! YANK(text) abort
    let escape = system('yank', a:text)
    if v:shell_error
        echoerr escape
    else
        call writefile([escape], '/dev/tty', 'b')
    endif
endfunction

" ## FILES function
" - ref: https://dev.to/pbnj/interactive-fuzzy-finding-in-vim-without-plugins-4kkj
function! FILES() abort
    let l:tempname = tempname()
    execute 'silent !files | awk ''{ print $1":1:0" }'' > ' . fnameescape(l:tempname)
    try
        execute 'cfile ' . l:tempname
        redraw!
    finally
        call delete(l:tempname)
    endtry
endfunction
command! Files call FILES()

" ## GFILES function
function! GFILES() abort
    let l:is_git = systemlist('git rev-parse --is-inside-work-tree 2>/dev/null')
    if v:shell_error || empty(l:is_git) || l:is_git[0] !=# 'true'
        echohl WarningMsg | echo "Not inside a git repository" | echohl None
        return
    endif

    let l:tempname = tempname()
    execute 'silent !gfiles | awk ''{ print $1":1:0" }'' > ' . fnameescape(l:tempname)
    try
        execute 'cfile ' . l:tempname
        redraw!
    finally
        call delete(l:tempname) " Clean up the temporary file
    endtry
endfunction
command! GFiles call GFILES()

" ## RG function
function! RG(args) abort
    let l:tempname = tempname()
    let l:pattern = '.'
    if len(a:args) > 0
        let l:pattern = a:args
    endif
    " rg --max-depth 1 --vimgrep <pattern> | fzf -m > file
    execute 'silent !rg --max-depth 1 --vimgrep ''' . l:pattern . ''' | fzf -m > ' . fnameescape(l:tempname)
    try
        execute 'cfile ' . l:tempname
        redraw!
    finally
        call delete(l:tempname)
    endtry
endfunction
command! -nargs=* Rg call RG(<q-args>)

" # color
" - ref: https://hamvocke.com/blog/ansi-vim-color-scheme/
"
" This color scheme relies on ANSI colors only. It automatically inherits
" the 16 colors of your terminal color scheme. You can change the colors of
" certain highlight groups by picking a different color from the following set
" of colors. If you sticked to the ANSI color palette conventions when setting
" colors in your terminal emulator, this will look pretty neat. If you used
" a terminal color scheme that uses a different convention (e.g. base16)
" colors will likely look very odd if you use this color scheme.
"
" 0: Black        │   8: Bright Black (dark gray)
" 1: Red          │   9: Bright Red
" 2: Green        │  10: Bright Green
" 3: Yellow       │  11: Bright Yellow
" 4: Blue         │  12: Bright Blue
" 5: Magenta      │  13: Bright Magenta
" 6: Cyan         │  14: Bright Cyan
" 7: White (gray) │  15: Bright White
"
" Use the 'cterm' argument to make certain highlight groups appear in italic
" (if your terminal and font support it), bold, reverse, underlined, etc.
" See ':help attr-list' for possible options.
set background=dark
hi clear
" - Force vim to use 16 colors only
set notermguicolors
" - Editor Elements
hi NonText                    ctermfg=0
hi Ignore                     cterm=NONE ctermfg=NONE  ctermbg=NONE
hi Underlined                 cterm=underline
hi Bold                       cterm=bold
hi Italic                     cterm=italic
hi StatusLine                 ctermfg=0 ctermbg=3 cterm=NONE
hi StatusLineNC               ctermfg=NONE ctermbg=0 cterm=NONE
hi VertSplit                  ctermfg=0 cterm=NONE
hi TabLine                    ctermfg=7 ctermbg=0
hi TabLineFill                ctermfg=0 ctermbg=NONE
hi TabLineSel                 ctermfg=0 ctermbg=11
hi Title                      ctermfg=4 cterm=NONE
hi CursorLine                 ctermfg=NONE ctermbg=0 cterm=NONE
hi Cursor                     ctermfg=0 ctermbg=15
hi CursorColumn               ctermfg=NONE ctermbg=0
hi LineNr                     ctermfg=NONE
hi CursorLineNr               ctermfg=NONE cterm=NONE
hi helpLeadBlank              ctermfg=NONE ctermbg=NONE
hi helpNormal                 ctermfg=NONE ctermbg=NONE
hi Visual                     cterm=bold ctermfg=15 ctermbg=8
hi VisualNOS                  cterm=bold ctermfg=15 ctermbg=8
hi Pmenu                      ctermfg=15 ctermbg=0
hi PmenuSbar                  ctermfg=7  ctermbg=8
hi PmenuSel                   ctermfg=15 ctermbg=8 cterm=NONE
hi PmenuThumb                 ctermfg=NONE ctermbg=7
hi FoldColumn                 ctermbg=NONE
hi Folded                     ctermfg=14 ctermbg=0
hi WildMenu                   ctermfg=15 ctermbg=0 cterm=NONE
hi SpecialKey                 ctermfg=NONE
hi IncSearch                  ctermfg=0 ctermbg=1
hi CurSearch                  ctermfg=0 ctermbg=3
hi Search                     ctermfg=0 ctermbg=11
hi Directory                  ctermfg=4
hi MatchParen                 ctermfg=3 ctermbg=0 cterm=underline
hi SpellBad                   cterm=undercurl
hi SpellCap                   cterm=undercurl
hi SpellLocal                 cterm=undercurl
hi SpellRare                  cterm=undercurl
hi ColorColumn                ctermbg=8
hi SignColumn                 ctermfg=7
hi ModeMsg                    ctermfg=NONE ctermbg=0
hi MoreMsg                    ctermfg=4
hi Question                   ctermfg=4
hi QuickFixLine               ctermfg=14 ctermbg=0
hi Conceal                    ctermfg=8
hi ToolbarLine                ctermfg=15 ctermbg=0
hi ToolbarButton              ctermfg=15 ctermbg=8
hi debugPC                    ctermfg=7
hi debugBreakpoint            ctermfg=8
hi ErrorMsg                   ctermfg=1 ctermbg=NONE cterm=bold,italic
hi WarningMsg                 ctermfg=11
hi DiffAdd                    ctermfg=0 ctermbg=10
hi DiffChange                 ctermfg=0 ctermbg=12
hi DiffDelete                 ctermfg=0 ctermbg=9
hi DiffText                   ctermfg=0 ctermbg=14
hi diffAdded                  ctermfg=10
hi diffRemoved                ctermfg=9
hi diffChanged                ctermfg=12
hi diffOldFile                ctermfg=11
hi diffNewFile                ctermfg=13
hi diffFile                   ctermfg=12
hi diffLine                   ctermfg=7
hi diffIndexLine              ctermfg=14
hi healthError                ctermfg=1 ctermbg=NONE
hi healthSuccess              ctermfg=2
hi healthWarning              ctermfg=3
hi TabLine                    cterm=NONE ctermfg=NONE ctermbg=0
hi TabLineFill                cterm=NONE ctermfg=NONE ctermbg=0
hi TabLineSel                 cterm=NONE ctermfg=0    ctermbg=3

" - Syntax
hi Comment ctermfg=14 cterm=italic
hi Constant ctermfg=3
hi Error ctermfg=1 ctermbg=NONE
hi Identifier ctermfg=9
hi Function ctermfg=4
hi Special ctermfg=13
hi Statement ctermfg=5
hi String ctermfg=2
hi Operator ctermfg=6
hi Boolean ctermfg=3
hi Label ctermfg=14
hi Keyword ctermfg=5
hi Exception ctermfg=5
hi Conditional ctermfg=5
hi PreProc ctermfg=13
hi Include ctermfg=5
hi Macro ctermfg=5
hi StorageClass ctermfg=11
hi Structure ctermfg=11
hi Todo ctermfg=0 ctermbg=14
hi Type ctermfg=11

" # vim-plug
" - ref: https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall to install plugins
" :PlugUpdate  to update plugins
" :PlugDiff    to review the changes from the last update
" :PlugClean   to remove plugins no longer in the list
call plug#begin()
    " - ref: https://raw.githubusercontent.com/tpope/vim-fugitive/master/doc/fugitive.txt
    "Plug 'tpope/vim-fugitive'
    " - ref: https://github.com/junegunn/vim-easy-align
    "Plug 'junegunn/vim-easy-align'
    Plug 'mtdl9/vim-log-highlighting'
call plug#end()

" # filetype
autocmd BufNewFile,BufRead *.vp setlocal filetype=systemverilog

"" git log -p -40 | vim - -R -c 'set foldmethod=syntax'
"autocmd BufReadPost,BufNewFile fugitive://* setlocal foldmethod=syntax

"" git log -p -40 | vim - -R -c 'set foldmethod=syntax'
"autocmd BufReadPost,BufNewFile fugitive://* set foldmethod=syntax







"local function run_ctags_uvm()
"    vim.cmd [[!rm -rf $HOME/.local/tags ]]
"    vim.cmd [[!mkdir $HOME/.local/tags ]]
"
"    --https://docs.ctags.io/en/latest/output-format.html
"    -- --extra=+q  - Enable hierarchy qualified tags extraction.
"    -- --fields=+i - Enable class inheritance extraction.
"    -- -n          - (Optional) Use line number instead of Ex: patterns to identify declaration.
"    vim.cmd [[!ctags --extras=+q --fields=+i -n --tag-relative=never --languages=systemverilog -R --exclude=.git -f $HOME/.local/tags/.uvm.tags $UVM_HOME/src ]]
"    vim.cmd [[!ctags --extras=+q --fields=+i -n --tag-relative=never                           -R --exclude=.git -f $HOME/.local/tags/.tags  .]]
"
"    vim.cmd [[ set tags=$HOME/.local/tags/.uvm.tags ]]
"    vim.cmd [[ set tags+=$HOME/.local/tags/.tags ]]
"end
"
"vim.keymap.set("n", "<leader>rt", run_ctags_uvm)
"
"-- :ltag(:lt) to load tag to quitfixlist
"-- :lope to open quitfixlist with tag







"--vim.cmd [[
"--    let s:vim_tags = expand('~/.cache/tags')
"--    let g:gutentags_cache_dir = s:vim_tags
"--    if !isdirectory(s:vim_tags)
"--        silent! call mkdir(s:vim_tags, 'p')
"--    endif
"--]]
"--vim.cmd [[ let g:gutentags_project_root = ['.root', '.git'] ]]
"--vim.cmd [[ let g:gutentags_ctags_tagfile = '.tags' ]]
"--vim.cmd [[ let g:gutentags_ctags_extra_args = ['-R', '--languages=systemverilog', '--extra=+q', '--fields=+i'] ]]

" - ref: https://dpwright.com/posts/2018/04/06/graphical-log-with-vimfugitive/
"command -nargs=* Glg Git! log --graph --color=always --pretty=format:'\%h - (\%ad)\%d \%s <\%an>' --abbrev-commit --date=local <args>
"
"autocmd User Fugitive command! -buffer -bar Gmylog exe 'terminal' FugitivePrepare(['log', '--oneline', '--decorate', '--graph', '--all'])

"syn match gitLgLine /^[_\*|\/\\ ]\+\(\<\x\{4,40\}\>.*\)\?$/
"syn match gitLgHead /^[_\*|\/\\ ]\+\(\<\x\{4,40\}\> - ([^)]\+)\( ([^)]\+)\)\? \)\?/ contained containedin=gitLgLine
"syn match gitLgDate /(\u\l\l \u\l\l \d\=\d \d\d:\d\d:\d\d \d\d\d\d)/ contained containedin=gitLgHead nextgroup=gitLgRefs skipwhite
"syn match gitLgRefs /([^)]*)/ contained containedin=gitLgHead
"syn match gitLgGraph /^[_\*|\/\\ ]\+/ contained containedin=gitLgHead,gitLgCommit nextgroup=gitHashAbbrev skipwhite
"syn match gitLgCommit /^[^-]\+- / contained containedin=gitLgHead nextgroup=gitLgDate skipwhite
"syn match gitLgIdentity /<[^>]*>$/ contained containedin=gitLgLine
"hi def link gitLgGraph Comment
"hi def link gitLgDate gitDate
"hi def link gitLgRefs gitReference
"hi def link gitLgIdentity gitIdentity




" - ref: https://github.com/kablamo/vim-git-log
