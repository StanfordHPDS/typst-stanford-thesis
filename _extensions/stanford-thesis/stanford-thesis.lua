local function is_typst_book()
  local file_state = quarto.doc.file_metadata()
  return quarto.doc.is_format("typst") and
         file_state ~= nil and
         file_state.file ~= nil
end

local seen_appendix = false
local part_counter = 0

local header_filter = {
  Header = function(el)
    if not is_typst_book() then
      return nil
    end

    local file_state = quarto.doc.file_metadata()
    if file_state == nil or file_state.file == nil then
      return nil
    end

    local bookItemType = file_state.file.bookItemType

    if el.level ~= 1 or bookItemType == nil then
      return nil
    end

    if bookItemType == "part" then
      part_counter = part_counter + 1
      -- Set part-number state before the heading so the Typst show rule
      -- can detect this is a part heading and render it as a centered divider.
      -- After the heading, reset to 0 so subsequent headings render normally.
      local before = pandoc.RawBlock("typst", string.format(
        '#state("part-number").update(%d)', part_counter
      ))
      local after = pandoc.RawBlock("typst",
        '#state("part-number").update(0)'
      )
      return { before, el, after }
    end

    if bookItemType == "appendix" and not seen_appendix then
      seen_appendix = true
      -- Mark this as the appendices divider heading, then reset after
      local before = pandoc.RawBlock("typst",
        '#counter(heading).update(0)\n#set heading(numbering: "A.1")\n#state("in-appendix").update(true)\n#state("is-appendices-divider").update(true)'
      )
      local after = pandoc.RawBlock("typst",
        '#state("is-appendices-divider").update(false)'
      )
      return { before, el, after }
    end

    return nil
  end
}

-- Two-pass approach for {#refs} handling:
-- Pass 1: Walk the document to find {#refs} and inject #bibliography() there
-- Pass 2: If found, set suppress-bibliography in metadata
-- Using Pandoc filter on the full document ensures correct ordering.
local refs_filter = {
  Pandoc = function(doc)
    if not quarto.doc.is_format("typst") then
      return nil
    end

    local meta = doc.meta
    if not meta or not meta.bibliography then
      return nil
    end

    -- Walk blocks to find and replace {#refs} div
    local found = false
    local new_blocks = pandoc.List()

    for _, block in ipairs(doc.blocks) do
      if block.t == "Div" and block.identifier == "refs" then
        found = true

        -- Build bibliography file list
        local bib_files = {}
        local bib = meta.bibliography
        if pandoc.utils.type(bib) == "List" then
          for _, b in ipairs(bib) do
            table.insert(bib_files, '"' .. pandoc.utils.stringify(b) .. '"')
          end
        else
          table.insert(bib_files, '"' .. pandoc.utils.stringify(bib) .. '"')
        end

        if #bib_files > 0 then
          local opts = { "title: none" }

          if meta["bibliography-full"] then
            local full_val = pandoc.utils.stringify(meta["bibliography-full"])
            if full_val == "true" then
              table.insert(opts, "full: true")
            end
          end

          local bib_call = "#bibliography((" ..
            table.concat(bib_files, ", ") .. "), " ..
            table.concat(opts, ", ") .. ")"

          new_blocks:insert(pandoc.RawBlock("typst", bib_call))
        end
      else
        new_blocks:insert(block)
      end
    end

    if found then
      doc.blocks = new_blocks
      doc.meta["suppress-bibliography"] = true
      return doc
    end

    return nil
  end
}

return quarto.utils.combineFilters({
  quarto.utils.file_metadata_filter(),
  header_filter,
  refs_filter
})
