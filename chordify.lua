-- Stack chord above following lyric token
local function mk_chorded(ch, lyric)
  ch = ch:gsub("^%s+", ""):gsub("%s+$", "")
  lyric = lyric or "&nbsp;"
  return pandoc.RawInline("html",
    '<span class="ch"><span class="chord">'..ch..
    '</span><span class="lyric">'..lyric..'</span></span>')
end

local function transform_inlines(inlines)
  local out, i = {}, 1
  while i <= #inlines do
    local el = inlines[i]
    if el.t == "Str" then
      local chord = el.text:match("^%[([^%]]+)%]$")
      if chord then
        local lyric, consumed = nil, 0
        local n1, n2 = inlines[i+1], inlines[i+2]
        if n1 and n1.t == "Str" then
          lyric, consumed = n1.text, 1
        elseif n1 and n1.t == "Space" and n2 and n2.t == "Str" then
          lyric, consumed = n2.text, 2
        end
        table.insert(out, mk_chorded(chord, lyric))
        i = i + 1 + consumed
      else
        table.insert(out, el); i = i + 1
      end
    else
      table.insert(out, el); i = i + 1
    end
  end
  return out
end

function Para(el)  el.content = transform_inlines(el.content); return el end
function Plain(el) el.content = transform_inlines(el.content); return el end
