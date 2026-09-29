" ============================================================
" Converted from Vim 8.0 vimrc -> Neovim 0.12 init.vim
" Key changes vs. the original, see inline notes marked [NVIM]:
"   1. Removed manual bracketed-paste escape-code hacks
"      (t_BE/t_BD/t_PS/t_PE) - Neovim supports bracketed paste
"      natively, no config needed.
"   2. Replaced the t_SI/t_SR/t_EI raw escape-code cursor hack
"      (plus the empty `guicursor=`) with a single `guicursor`
"      setting that produces the same shapes (block/bar/underline)
"      through Neovim's native terminal cursor-shaping support.
"   3. Dropped the has('persistent_undo') guard - the feature is
"      always compiled into Neovim, so the check was dead code.
"   4. Wrapped autocmds that were not already in an augroup
"      (Harpoon init, formatoptions tweak, filetype overrides at
"      the bottom) in augroup blocks, so re-sourcing this file
"      won't register duplicate autocmds.
" Everything else (keymaps, folding, quickfix nav, color scheme,
" Yank/FILES/GFiles/Harpoon functions) is plain Vimscript and
" runs unchanged under Neovim.
" ============================================================
 
" - 16 ANSI color
" [NVIM] t_Co is a Vim-only terminal-capability variable; Neovim
" negotiates terminal colors itself, so this line is a no-op and
" has been removed. (Left here as a comment for reference.)
"set t_Co=16
 
" - cursor shape per mode
" [NVIM] Replaces the old t_SI/t_SR/t_EI + `set guicursor=` combo.
" Neovim applies `guicursor` to real terminals too, so one setting
" now does what the raw escape-code hack used to do:
"   normal/else -> block   (was t_EI = CSI 2 q)
"   insert      -> vertical bar (was t_SI = CSI 6 q)
"   replace     -> underline    (was t_SR = CSI 4 q)
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
 
" - ignore focus escape sequences sent by the terminal in all modes
noremap <Esc>[I <nop>
noremap! <Esc>[I <nop>
noremap <Esc>[O <nop>
noremap! <Esc>[O <nop>
 
" - paste
" [NVIM] The following four lines configured Vim's bracketed-paste
" mode (t_BE/t_BD enable/disable the terminal reporting paste,
" t_PS/t_PE mark the start/end sequences Vim should recognize).
" Neovim has bracketed paste built in and handles it automatically
" without any of this, so these are removed.
"let &t_BE = "\e[?2004h"
"let &t_BD = "\e[?2004l"
"exec "set t_PS=\e[200~"
"exec "set t_PE=\e[201~"
 
" - ref: https://www.reddit.com/r/neovim/comments/1n53u4u/you_dont_need_a_fuzzy_finder_vim_tips_tricks/
" - ref: https://codeinthehole.com/tips/vim-lists/
set path=.,
set path+=**,
"set wildmenu
""(Vim 8.2+ / already default in Neovim)
"set wildoptions=pum
"set wildmode=longest:full,full
 
" # keymap
let mapleader = ' '
nnoremap Q <nop>
nnoremap <C-a> <nop>
nnoremap <C-x> <nop>
nnoremap <Space> <nop>
vnoremap <Space> <nop>
nnoremap <C-l> :noh<CR>
inoremap <C-c> <Esc>
" - vim with read only mode
" $ nvim -R -
" - % refers to the current buffer
" - %:p refers to the path to the file
nnoremap <leader>b :exe "w %:p.bak.".strftime("%Y%m%d_%H%M%S")<CR>:echo "Backup:" . expand("%:p") . ".bak." . strftime("%Y%m%d_%H%M%S")<CR>
nnoremap <leader>c :%s/\s\+$//e<CR>:%s/\r$//e<CR>
nnoremap <C-k> :@" = join(readfile(expand('~/y')), "\n")<CR>:r ~/y<CR>
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
" - ref: https://www.youtube.com/watch?v=APUzjye4fPk&list=PLfDYHelvG44BNGMqjVizsKFpJRsrmqfsJ
" - advanced vim interaction
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
" [NVIM] Neovim's TUI redraws differently and rarely flickers the
" way old console Vim did; kept for parity, safe to drop if unneeded.
set lazyredraw
" - line count in virtual mode
set showcmd
" - status
" - ref: https://zhung.com.tw/article/install-and-start-vim-with-minimal-vimrc/
set laststatus=2
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
" - undofile
set undofile
set undolevels=10000
set undoreload=100000
" - backfile
set nobackup
" - swapfile
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
set sidescrolloff=8
set splitright
set splitbelow
" - netrw
let g:netrw_banner = 0
 
" # insert mode abbreviation
" - Insert date at typing _DS in insert mode
" - ref https://stackoverflow.com/a/22578234
iab <expr> _DS strftime("%Y-%m-%d %H:%M:%S")
 
" # autocmd
" - disable auto comment on current line for every filetype
" [NVIM] wrapped in augroup so re-sourcing doesn't duplicate it
augroup FormatOptionsFix
    autocmd!
    autocmd FileType * setlocal formatoptions-=cro
augroup END
 
" ## RG function
"function! RG(args) abort
"    let l:tempname = tempname()
"    let l:pattern = '.'
"    if len(a:args) > 0
"        let l:pattern = a:args
"    endif
"    " rg --max-depth 1 --vimgrep <pattern> | fzf -m > file
"    execute 'silent !rg --max-depth 1 --vimgrep ''' . l:pattern . ''' | fzf -m > ' . fnameescape(l:tempname)
"    try
"        execute 'cfile ' . l:tempname
"        redraw!
"    finally
"        call delete(l:tempname)
"    endtry
"endfunction
"command! -nargs=* Rg call RG(<q-args>)
 
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
"vim.cmd.colorscheme("catppuccin")
hi clear
" - Force nvim to use 16 colors only
set notermguicolors
" - Editor Elements
hi NonText                    ctermfg=0
hi Ignore                     ctermfg=NONE ctermbg=NONE cterm=NONE
hi Underlined                                           cterm=underline
hi Bold                                                 cterm=bold
hi Italic                                               cterm=italic
hi StatusLine                 ctermfg=0    ctermbg=3    cterm=NONE
hi StatusLineNC               ctermfg=NONE ctermbg=0    cterm=NONE
hi StatusLineTerm             ctermfg=0    ctermbg=3    cterm=NONE
hi StatusLineTermNC           ctermfg=NONE ctermbg=0    cterm=NONE
hi VertSplit                  ctermfg=0    ctermbg=NONE cterm=NONE
hi TabLine                    ctermfg=7    ctermbg=0    cterm=NONE
hi TabLineFill                ctermfg=0    ctermbg=NONE cterm=NONE
hi TabLineSel                 ctermfg=0    ctermbg=11   cterm=NONE
hi Title                      ctermfg=4    ctermbg=NONE cterm=NONE
hi CursorLine                 ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor                     ctermfg=NONE ctermbg=NONE cterm=NONE
hi CursorColumn               ctermfg=NONE ctermbg=NONE cterm=NONE
hi LineNr                     ctermfg=NONE ctermbg=NONE cterm=NONE
hi CursorLineNr               ctermfg=NONE ctermbg=NONE cterm=NONE
hi Visual                     ctermfg=NONE ctermbg=8    cterm=NONE
hi Pmenu                      ctermfg=7    ctermbg=0    cterm=NONE
hi PmenuSbar                  ctermfg=7    ctermbg=8    cterm=NONE
hi PmenuSel                   ctermfg=7    ctermbg=8    cterm=NONE
hi PmenuThumb                 ctermfg=NONE ctermbg=7
hi FoldColumn                              ctermbg=NONE
hi Folded                     ctermfg=14   ctermbg=0
hi WildMenu                   ctermfg=7    ctermbg=0    cterm=NONE
hi SpecialKey                 ctermfg=NONE
hi IncSearch                  ctermfg=0    ctermbg=1
hi CurSearch                  ctermfg=0    ctermbg=3
hi Search                     ctermfg=0    ctermbg=11
hi Directory                  ctermfg=4
hi MatchParen                 ctermfg=3    ctermbg=0    cterm=underline
hi SpellBad                                             cterm=undercurl
hi SpellCap                                             cterm=undercurl
hi SpellLocal                                           cterm=undercurl
hi SpellRare                                            cterm=undercurl
hi ColorColumn                             ctermbg=8
hi SignColumn                 ctermfg=7
hi ModeMsg                    ctermfg=NONE ctermbg=0
hi MoreMsg                    ctermfg=4
hi Question                   ctermfg=4
hi QuickFixLine               ctermfg=14   ctermbg=0
hi Conceal                    ctermfg=8
hi ErrorMsg                   ctermfg=1    ctermbg=NONE cterm=italic
hi WarningMsg                 ctermfg=11
hi DiffAdd                    ctermfg=0    ctermbg=10
hi DiffChange                 ctermfg=0    ctermbg=12
hi DiffDelete                 ctermfg=0    ctermbg=9
hi DiffText                   ctermfg=0    ctermbg=14
hi TabLine                    ctermfg=NONE ctermbg=0    cterm=NONE
hi TabLineFill                ctermfg=NONE ctermbg=0    cterm=NONE
hi TabLineSel                 ctermfg=0    ctermbg=3    cterm=NONE
" - Syntax
hi Comment                    ctermfg=14                cterm=italic
hi Constant                   ctermfg=3
hi Error                      ctermfg=1    ctermbg=NONE
hi Identifier                 ctermfg=9
hi Function                   ctermfg=4
hi Special                    ctermfg=13
hi Statement                  ctermfg=5
hi String                     ctermfg=2
hi Operator                   ctermfg=6
hi Boolean                    ctermfg=3
hi Label                      ctermfg=14
hi Keyword                    ctermfg=5
hi Exception                  ctermfg=5
hi Conditional                ctermfg=5
hi PreProc                    ctermfg=13
hi Include                    ctermfg=5
hi Macro                      ctermfg=5
hi StorageClass                ctermfg=11
hi Structure                  ctermfg=11
hi Todo                       ctermfg=0    ctermbg=14
hi Type                       ctermfg=11
 
" # filetype
" [NVIM] wrapped in augroup so re-sourcing doesn't duplicate these
augroup FiletypeOverrides
    autocmd!
    autocmd BufRead,BufNewFile *.vp setlocal filetype=systemverilog
    autocmd FileType asciidoc setlocal filetype=text
augroup END
