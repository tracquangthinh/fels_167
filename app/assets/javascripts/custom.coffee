$(document).on 'ready page:load', ->
  $('#user_avatar').bind 'change', ->
    size = @files[0].size / 1024
    if size > 100
      alert 'Maximum file size is 100Kb'

  $('#searchWord').keyup ->
    value = $(this).val()
    $('ol li').each ->
      if $(this).text().search(value) > -1
        $(this).show()
      else
        $(this).hide()

  sortWords = ->
    values = []
    list = $('ol li')
    list.each ->
      values.push $(this).text()
    values.sort
    values.reverse()
    i = 0
    while i < list.length
      list[i].innerHTML = '<p>' + values[i] + '</p>'
      i++
  
  desc = true
  $('#desc').click ->
    if desc
      sortWords()
      desc = false
      $(this).attr 'checked', true
  $('#asc').click ->
    if !desc
      sortWords()
      desc = true

  $('#new_category').submit (e) ->
    e.preventDefault()
    action = $(this).attr('action')
    method = $(this).attr('method')
    data = $(this).serializeArray();
    $.ajax
      url: action
      method: method
      data: data
      dataType: 'json'
      success: (result) ->
        $('#newCategoryModal').modal('toggle');
        alert 'Create successful'
        $('#tableHeading').remove();
        $('#tableCategoriesResult').prepend(newCategory(result))
        $('#tableCategoriesResult').prepend(headingTable)
      error: (result) ->
        alert 'Can\'t create category. Check information please'
  
  headingTable = ->
    res = '<tr id="tableHeading"><th></th>'
    res += '<th class="text-center">ID</th>'
    res += '<th class="text-center">Name</th>'
    res += '<th class="text-center">Description</th>'
    res += '<th class="text-center">Total words</th></tr>'
    res

  newCategory = (result) ->
    res = '<tr><td col-md-1><input name="category_ids[]"'
    res += 'id="category_ids_" value="'
    res += result.id
    res += '" type="checkbox"></td>'
    res += '<td class="col-md-1 text-center">' + result.id + '</td>'
    res += '<td class="col-md-2 text-center">' + result.name + '</td>'
    res += '<td class="col-md-3 text-center">' + result.description + '</td>'
    res += '<td class="col-md-5 text-center">' + result.numberWords + '</td>'
    res += '<td class="text-center"><a data-toggle="tooltip" title="Edit" '
    res += 'href="/admin/categories/'
    res += result.id + '">'
    res += '<i class="glyphicon glyphicon-pencil"></i></a></td>'
    res += '<td class="text-center"><a data-toggle="tooltip" title="Delete" '
    res += 'data-confirm="Are you sure?" rel="nofollow" data-method="delete" '
    res += 'href="/admin/categories/'
    res += result.id + '">'
    res += '<i class="glyphicon glyphicon-trash"></i></a></td></tr>'
    res
