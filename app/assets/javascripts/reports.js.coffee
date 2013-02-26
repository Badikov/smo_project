# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
   	$('#today_table_id, #jobs_table_id, #age14_table_id, #foreigners_table_id').dataTable
    	sPaginationType: "full_numbers"
    	bJQueryUI: true

    menu_line = $("#input_date")
    menu_line
     .mouseover ->
      pos = $(@).offset()
      w = $(@).width()
      $("#menu_datepicker")
       .css 
        'position': 'fixed'
        'top': pos.top
        'left': pos.left + w
       .datepicker()
       .show()
     .mouseout ->
      $("#menu_datepicker").hide()
     