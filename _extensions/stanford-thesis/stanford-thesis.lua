local function is_typst_book()
  local file_state = quarto.doc.file_metadata()
  return quarto.doc.is_format("typst") and
         file_state ~= nil and
         file_state.file ~= nil
end

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

    return nil
  end
}

return quarto.utils.combineFilters({
  quarto.utils.file_metadata_filter(),
  header_filter
})
