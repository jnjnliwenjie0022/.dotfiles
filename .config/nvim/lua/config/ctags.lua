function run_ctags()
    vim.cmd [[!rm -rf $HOME/.local/tags ]]
    vim.cmd [[!mkdir $HOME/.local/tags ]]

    --https://docs.ctags.io/en/latest/output-format.html
    vim.cmd [[!ctags -f $HOME/.local/tags/.uvm1.1d.tags --languages=systemverilog --tag-relative=never -R $HOME/synopsys/uvm-1.1d/src ]]
    vim.cmd [[!ctags -f $HOME/.local/tags/.tags --tag-relative=never --exclude=.git -R .]]

    vim.cmd [[ set tags=$HOME/.local/tags/.uvm1.1d.tags ]]
    vim.cmd [[ set tags+=$HOME/.local/tags/.tags ]]
end

vim.keymap.set("n", "<leader>rt", run_ctags)
