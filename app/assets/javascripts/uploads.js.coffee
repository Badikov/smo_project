# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("a.numbers-line-remove").live 'click', ->
  	$(@).parent().remove()
  	return false
  $("a.numbers-line-add").click ->
  	n = $("div.numbers-line").length
  	html = '<div class="numbers-line"><input id="line'+n+'_series" type="text" placeholder="серия" name="line'+n+'_series"><input id="line'+n+'_start" type="text" placeholder="c..." name="line'+n+'_start"><input id="line'+n+'_end" type="text" placeholder="по..." name="line'+n+'_end"><a class="numbers-line-remove" href="/uploads/numbers">Удалить</a></div>'
  	$("p#numbers_line_add").before html
  	return false
  $("#new_xml").fileupload()
  #   dataType: "json"
  #   done: (e, data)->
  #     $.each data.result, (index, file)->
  #       $('<p/>').text file.name 
  #       .appendTo document.body