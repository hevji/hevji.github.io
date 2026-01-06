-- Simple Lua script to read redirect.xml and redirect the browser
local xml = require("xml") -- you need a Lua XML parser
local lfs = require("lfs") -- for file access

-- Load XML
local file = io.open("redirect.xml", "r")
local content = file:read("*a")
file:close()

local parsed = xml.load(content) -- parses <redirect><url>...</url></redirect>
local target_url = parsed:find("url")[1] -- get the URL content

-- Output HTML meta redirect
print("<!DOCTYPE html>")
print("<html><head>")
print('<meta http-equiv="refresh" content="0;url=' .. target_url .. '">')
print("</head><body></body></html>")
