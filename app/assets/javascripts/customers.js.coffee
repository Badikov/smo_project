# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#customers_search_query").focus()

  $("form").live "keydown", (event) -> 
    e = event || window.event
    if e.keyCode is 13
      return false
  
  $("#customers_search_query").keyup (event) -> 
    e = event || window.event
    if e.keyCode is 32
      if (@.value).length > 3
        term = $.trim @.value
        $.ajax
          url: '/customers',
          type: 'GET',
          dataType: 'html'
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
      
  #-- выбытие застрахованного по П021
  $("#customers_search_021").live "click", (event) -> 
    e = event || window.event
    e.preventDefault()
    $.ajax
      type: "GET"
      url: @href
      success: (response) ->
        if response == 200
          $('.row')
            .before '<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">×</button>Застрахованное лицо выведено из действующих</div>'
        else
          $('.row')
            .before '<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">×</button>Не удалось выполнить операцию</div>'
 
  #-- выбытие застрахованного по П022      
  $("#dp_date_of_death").live "focus", ->
    $("#dp_date_of_death").datepicker
      beforeShow: (input) ->
        $(input).css('background-color', "#ff9")
      onSelect: (dateText, inst) ->
        $(@).css('background-color', "")
        $("#customers_search_022").removeAttr 'disabled'
    
  $("#customers_search_022").live "click", ->
    $.ajax
      type: "POST"
      dataType: 'json'
      url: '/customers/death_of_customer'
      data:
        date: $("#dp_date_of_death").datepicker 'getDate'
        id: $("#customers_search_customer_id").val()
      success: (response) ->
        $("#deathModal").modal 'hide'
        if response == 200
          $('.row')
            .before '<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">×</button>Застрахованное лицо выведено из действующих</div>'
        else
          $('.row')
            .before '<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">×</button>Не удалось выполнить операцию</div>'
  
  #-- выдача на руки полиса по П060
  $("#dp_date_begin").live "focus", ->
    $("#dp_date_begin").datepicker
      beforeShow: (input) ->
        $(input).css('background-color', "#ff9")
      onSelect: (dateText, inst) ->
        $(@).css('background-color', "")
        $("#customers_search_060").removeAttr 'disabled'

  #-- подгружает формы на странице http://localhost:3000/customers/{id}/edit
  $("#customers_edit_doc, #customers_edit_person").click ->
    $.ajax
      type: "GET"
      dataType: "html"
      url: @href
      success: (data) ->
        $("div.person-block").remove()
        $("div.page-body").append data
        doc_style_()
      error: (jqXHR, textStatus, errorThrown) -> alert errorThrown
    return false

  clear_person_info = () ->
    $("div#customers_customer_info div.personale").remove()
  person_info = (data) ->
    $("div#customers_customer_info").append data
  
  table_rows = (data) ->
    clear_person_info()
    $("#customers_table_search tbody").remove()
    $("#customers_table_search").append data
    #// $.map data, (item) ->
    #//   $("#customers_table_search").append '<tr id=' + item.id + '><td>' + item.fam +  '</td><td>' + item.im +  '</td><td>' + item.ot +  '</td><td>' + item.w +  '</td><td>' + item.dr +  '</td><td>' + item.docser +  '</td><td>' + item.docnum +  '</td></tr>'