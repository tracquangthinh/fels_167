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
