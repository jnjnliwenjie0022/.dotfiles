function ColorConfig()
    vim.cmd [[ set background=dark ]]
    local status, n = pcall(require, "catppuccin")
    if (status) then
        --https://www.color-hex.com/color/9090a0
        --https://www.ditig.com/256-colors-cheat-sheet
        --https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
        --https://github.com/srcery-colors/srcery-vim
        --16  Grey0     #1c1c1c rgb(0,0,0)
        --22  DarkGreen #005f00 rgb(0,95,0)
        --52  DarkRed   #5f0000 rgb(95,0,0)
        --190 Yellow2   #d7ff00 rgb(215,255,0)
        --233 Grey7     #121212 rgb(18,18,18)
        --234 Grey11    #1c1c1c rgb(28,28,28)
        --243 Grey46	#767676	rgb(118,118,118)
        --242 Grey42    #6c6c6c rgb(108,108,108)
        --255 Grey93    #eeeeee rgb(238,238,238)
        vim.cmd [[ colorscheme catppuccin-mocha ]]
        vim.cmd [[ set cursorline]]
        vim.cmd [[ hi Normal       gui=NONE               guibg=#1c1c1c ]]
        vim.cmd [[ hi NormalNC     gui=NONE               guibg=#1c1c1c ]]
        vim.cmd [[ hi LineNr       gui=NONE guifg=#cdd6f4 guibg=#1c1c1c ]]
        vim.cmd [[ hi CursorLine   gui=NONE               guibg=#1c1c1c ]]
        vim.cmd [[ hi CursorLineNr gui=NONE guifg=#cdd6f4 guibg=#1c1c1c ]]
        vim.cmd [[ hi VertSplit    gui=NONE guifg=#cdd6f4 guibg=#1c1c1c ]]
        vim.cmd [[ hi Search       gui=NONE guifg=#1c1c1c guibg=#d7ff00 ]]
        vim.cmd [[ hi IncSearch    gui=NONE guifg=#1c1c1c guibg=#d7ff00 ]]
        vim.cmd [[ hi Folded       gui=NONE guifg=#87ffff guibg=#1c1c1c ]]
        vim.cmd [[ hi FoldColumn   gui=NONE guifg=#87ffff guibg=#1c1c1c ]]
        vim.cmd [[ hi Comment      gui=NONE guifg=#87ffff guibg=#1c1c1c ]]
        vim.cmd [[ hi Visual       gui=NONE               guibg=#808080 ]]
        --DiffAdd     diff mode: Added line
        --DiffChange  diff mode: Changed line
        --DiffDelete  diff mode: Deleted line
        --DiffText    diff mode: Changed text within a changed line
        vim.cmd [[ hi DiffAdd      gui=NONE guifg=NONE    guibg=#005f00 ]]
        vim.cmd [[ hi DiffDelete   gui=NONE guifg=#1c1c1c guibg=#1c1c1c ]]
        vim.cmd [[ hi DiffChange   gui=NONE guifg=NONE    guibg=#5f0000 ]]
        vim.cmd [[ hi DiffText     gui=NONE guifg=NONE    guibg=#5f0000 ]]
    else
        print("Catppuccin is not installed")
        vim.cmd [[ Normal       guifg=#f0f0f8 guibg=#000000 ]]

        -- Search
        vim.cmd [[ IncSearch    gui=UNDERLINE guifg=#80ffff guibg=#0060c0 ]]
        vim.cmd [[ Search       gui=NONE guifg=#f0f0f8 guibg=#0060c0 ]]

        -- Messages
        vim.cmd [[ ErrorMsg     gui=BOLD guifg=#ffa0ff guibg=NONE ]]
        vim.cmd [[ WarningMsg   gui=BOLD guifg=#ffa0ff guibg=NONE ]]
        vim.cmd [[ ModeMsg      gui=BOLD guifg=#40f0d0 guibg=NONE ]]
        vim.cmd [[ MoreMsg      gui=BOLD guifg=#00ffff guibg=#008070 ]]
        vim.cmd [[ Question     gui=BOLD guifg=#e8e800 guibg=NONE ]]

        -- Split area
        vim.cmd [[ StatusLine   gui=NONE guifg=#000000 guibg=#c8c8d8 ]]
        vim.cmd [[ StatusLineNC gui=NONE guifg=#707080 guibg=#c8c8d8 ]]
        vim.cmd [[ VertSplit    gui=NONE guifg=#606080 guibg=#c8c8d8 ]]
        vim.cmd [[ WildMenu     gui=NONE guifg=#000000 guibg=#a0a0ff ]]

        -- Diff
        vim.cmd [[ DiffText     gui=NONE guifg=#ff78f0 guibg=#a02860 ]]
        vim.cmd [[ DiffChange   gui=NONE guifg=#e03870 guibg=#601830 ]]
        vim.cmd [[ DiffDelete   gui=NONE guifg=#a0d0ff guibg=#0020a0 ]]
        vim.cmd [[ DiffAdd      gui=NONE guifg=#a0d0ff guibg=#0020a0 ]]

        -- Cursor
        vim.cmd [[ Cursor       gui=NONE guifg=#00ffff guibg=#008070 ]]
        vim.cmd [[ lCursor      gui=NONE guifg=#ffffff guibg=#8800ff ]]
        vim.cmd [[ CursorIM     gui=NONE guifg=#ffffff guibg=#8800ff ]]

        -- Fold
        vim.cmd [[ Folded       gui=NONE guifg=#40f0f0 guibg=#005080 ]]
        vim.cmd [[ FoldColumn   gui=NONE guifg=#40c0ff guibg=#00305c ]]

        -- Other
        vim.cmd [[ Directory    gui=NONE guifg=#40f0d0 guibg=NONE ]]
        vim.cmd [[ LineNr       gui=NONE guifg=#9090a0 guibg=NONE ]]
        vim.cmd [[ NonText      gui=BOLD guifg=#4080ff guibg=NONE ]]
        vim.cmd [[ SpecialKey   gui=BOLD guifg=#8080ff guibg=NONE ]]
        vim.cmd [[ Title        gui=BOLD guifg=#f0f0f8 guibg=NONE ]]
        vim.cmd [[ Visual       gui=NONE guifg=#e0e0f0 guibg=#707080 ]]

        -- Syntax group
        vim.cmd [[ Comment      gui=NONE guifg=#90d0ff guibg=NONE ]]
        vim.cmd [[ Constant     gui=NONE guifg=#90d0ff guibg=NONE ]]
        vim.cmd [[ Error        gui=BOLD guifg=#ffffff guibg=#ff0088 ]]
        vim.cmd [[ Identifier   gui=NONE guifg=#40f0f0 guibg=NONE ]]
        vim.cmd [[ Ignore       gui=NONE guifg=#000000 guibg=NONE ]]
        vim.cmd [[ PreProc      gui=NONE guifg=#40f0a0 guibg=NONE ]]
        vim.cmd [[ Special      gui=NONE guifg=#e0e080 guibg=NONE ]]
        vim.cmd [[ Statement    gui=NONE guifg=#ffa0ff guibg=NONE ]]
        vim.cmd [[ Todo         gui=BOLD guifg=#ffa0a0 guibg=NONE ]]
        vim.cmd [[ Type         gui=NONE guifg=#ffc864 guibg=NONE ]]
        vim.cmd [[ Underlined   gui=UNDERLINE guifg=#f0f0f8 guibg=NONE ]]

        -- HTML
        vim.cmd [[ htmlLink                 gui=UNDERLINE ]]
        vim.cmd [[ htmlBold                 gui=BOLD ]]
        vim.cmd [[ htmlBoldItalic           gui=BOLD,ITALIC ]]
        vim.cmd [[ htmlBoldUnderline        gui=BOLD,UNDERLINE ]]
        vim.cmd [[ htmlBoldUnderlineItalic  gui=BOLD,UNDERLINE,ITALIC ]]
        vim.cmd [[ htmlItalic               gui=ITALIC ]]
        vim.cmd [[ htmlUnderline            gui=UNDERLINE ]]
        vim.cmd [[ htmlUnderlineItalic      gui=UNDERLINE,ITALIC ]]
    end
end

function ColorCommentEn() 
    vim.cmd [[ hi Comment      gui=NONE guifg=#87ffff guibg=#1c1c1c ]]
end

function ColorCommentDn()
    vim.cmd [[ hi Comment      gui=NONE guifg=NONE guibg=#1c1c1c ]]
end

ColorConfig()
