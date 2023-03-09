local M = {}

function M.contains(tbl, val)
    for k,v in pairs(tbl) do
        if v == val then return k end
    end
end

return M
