# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#customers_search_query").keyup (event) -> 
    e = event || window.event
    if e.keyCode is 32
      if (@.value).length > 3
        term = $.trim @.value
        $.ajax
          url: '/customers',
          type: 'GET',
          data:
            term: term.toUpperCase()
          success: (data) -> table_rows data
          error: (jqXHR, textStatus, errorThrown) -> alert errorThrown
  
  $("#customers_table_search.table-hover tbody tr").live "click", ->
    clear_person_info()
    $("#customers_table_search.table-hover tbody tr").each (i) ->
      if $(@).hasClass "info"
        $(@).removeClass "info"
        
    $(@).addClass "info"
    $.ajax
      url: '/customers/search_person',
      type: 'GET',
      data:
        id: @id
      dataType: 'html'
      success: (data) -> 
        person_info data
      error: (jqXHR, textStatus, errorThrown) -> alert errorThrown
  
  clear_person_info = () ->
    $("div#customers_customer_info div.person-block").remove()
  person_info = (data) ->
    $("div#customers_customer_info").append data
  
  table_rows = (data) ->
    clear_person_info()
    $("#customers_table_search tbody").remove()
    $.map data, (item) ->
      $("#customers_table_search").append '<tr id=' + item.id + '><td>' + item.fam +  '</td><td>' + item.im +  '</td><td>' + item.ot +  '</td><td>' + item.w +  '</td><td>' + item.dr +  '</td><td>' + item.docser +  '</td><td>' + item.docnum +  '</td></tr>'