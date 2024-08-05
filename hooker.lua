require("example.lua") --require here ur lua script

---@diagnostic disable
local ffi_og = require"ffi"
ffi = {}
for name, func in pairs(ffi_og) do
    local func_og = func
    ffi[name] = setmetatable({}, {
        __tostring = function(self)
            return tostring(func_og)
        end,
        __call = function(self, ...)
            local text = "\n\n----new ffi call----\n\ncalled new ffi." .. name ..  "with args: \n"
            local args = {...}
            for i = 1, #args do
                text = text .. tostring(args[i]):gsub(" ", "")
            end
            print(text .. "\n----end ffi call----\n\n")
            return func_og(...)
        end
    })
end
local os_og = os
os = {}
for name, func in pairs(os_og) do
    local func_og = func
    os[name] = setmetatable({}, {
        __tostring = function(self)
            return tostring(func_og)
        end,
        __call = function(self, ...)
            local text = "\n\n----new ffi call----\n\ncalled new ffi." .. name ..  "with args: \n"
            local args = {...}
            for i = 1, #args do
                text = text .. tostring(args[i]):gsub(" ", "")
            end
            print(text .. "\n----end ffi call----\n\n")
            return func_og(...)
        end
    })
end
local pcall_og = pcall
pcall = setmetatable({}, {
   -- __tostring = function(self)
   --     return "function: builtin#20"
   --    end,
    __call = function(self, ...)
        local args = {...}
        local text = "called pcall with args:"
        for i = 1, #args do
            text = text .. " " ..(tostring(args[i]) or "nil")
        end
        print(text)
        return pcall_og(...)
    end
})
local xpcall_og = pcall
xpcall = setmetatable({}, {
    --__tostring = function(self)
    --    return "function: builtin#21"
    -- end,
    __call = function(self, ...)
        local args = {...}
        local text = "called pcall with args:"
        for i = 1, #args do
            text = text .. " " ..(tostring(args[i]) or "nil")
        end
        print(text)
        return xpcall_og(...)
    end
})

--#endregion
