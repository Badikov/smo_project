# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#new_xml").fileupload()
  #   dataType: "json"
  #   done: (e, data)->
  #     $.each data.result, (index, file)->
  #       $('<p/>').text file.name 
  #       .appendTo document.body