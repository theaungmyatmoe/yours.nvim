local ok, toggle_term = pcall(require, 'toggleterm')
if not ok then 
    return 
end

toggle_term.setup {}
