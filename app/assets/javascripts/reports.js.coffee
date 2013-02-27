# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
   	$('#today_table_id, #jobs_table_id, #age14_table_id, #foreigners_table_id').dataTable
    	sPaginationType: "full_numbers"
    	bJQueryUI: true

#    menu_line = $("#input_date")
#    menu_line
#     .mouseover ->
#      pos = $(@).offset()
#      w = $(@).width()
#      $("#menu_datepicker")
#       .css 
#        'position': 'fixed'
#        'top': pos.top
#        'left': pos.left + w
#       .datepicker()
#       .show().mouseout ->
#      $("#menu_datepicker").hide()
    $("#menu_datepicker")
      .datepicker
        numberOfMonths: 2
        showButtonPanel: true
        minDate: new Date(2011, 1 - 1, 1)
        maxDate: "-1d"
        onSelect: (dateText, inst) ->
          date_at dateText
    date_at = (_date) ->
      _date = {date: _date}
      $(window.location).attr "href", '/reports/date_at?' + $.param _date

     