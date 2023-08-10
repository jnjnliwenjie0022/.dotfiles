function run_ctags_uvm()
    vim.cmd [[!rm -rf $HOME/.local/tags ]]
    vim.cmd [[!mkdir $HOME/.local/tags ]]

    --https://docs.ctags.io/en/latest/output-format.html
    -- --extra=+q  - Enable hierarchy qualified tags extraction.
    -- --fields=+i - Enable class inheritance extraction.
    -- -n          - (Optional) Use line number instead of Ex: patterns to identify declaration.
    vim.cmd [[!ctags --extras=+q --fields=+i -n --tag-relative=never --languages=systemverilog -R --exclude=.git -f $HOME/.local/tags/.uvm.tags $UVM_HOME/src ]]
    vim.cmd [[!ctags --extras=+q --fields=+i -n --tag-relative=never --languages=systemverilog -R --exclude=.git -f $HOME/.local/tags/.tags  .]]

    vim.cmd [[ set tags=$HOME/.local/tags/.uvm.tags ]]
    vim.cmd [[ set tags+=$HOME/.local/tags/.tags ]]
end

vim.keymap.set("n", "<leader>rt", run_ctags_uvm)

