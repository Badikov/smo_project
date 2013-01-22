# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$("#ate_nameate").prepend '<option value="0" select="selected">Территории Кемеровской области</option>'
	$("#ate_nameate").change () ->
	  $.ajax
      type: "POST"
      dataType: 'json'
      data:
        $('form[id*="edit_ate"]').serialize() 
      success: (response) ->
      error: (jqXHR, textStatus, errorThrown) -> alert errorThrown
    return false