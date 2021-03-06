# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('form[id*="edit_vizit"] input#vizit_insurance_polis_npolis').val (index, value) ->
    if value.length isnt 6
      value = ''
    else
      value

  $('form[id*="edit_vizit"] input[id*="vizit_rpolis"]').each (i) ->
    if (i == 0) || (i == 1) || (i == 4)
      $(@).parent().hide()
    
  $("#customers_table_search").hide()

  $("#customers_search_query").focus()

  $("form").bind "keydown", (event) -> 
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
          success: (data) -> 
            table_rows data
            $("#customers_table_search").show()
          error: (jqXHR, textStatus, errorThrown) -> alert errorThrown
  
  $("#customers_table_search.table-hover").on "click","tbody tr", (e) ->
    e.preventDefault()
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
  #=======================================================================================================
  $("div#customers_customer_info").on "click","#customers_search_021", (event) ->
    e = event || window.event
    if confirm('Вы уверенны что это лицо выбыло ?')
      $.ajax
        type: "GET"
        url: @href
        success: (data, textStatus, jqXHR) ->
          $('.row').before data
        error: (jqXHR, textStatus, errorThrown) ->
          alert errorThrown
      return false
    e.preventDefault()
  #-- выбытие застрахованного по П023
  #=======================================================================================================
  $("div#customers_customer_info").on "click","#customers_search_023", (event) ->
    e = event || window.event
    if confirm('Вы уверенны что это дубликат ?')
      $.ajax
        type: "GET"
        url: @href
        success: (data, textStatus, jqXHR) ->
          $('.row').before data
        error: (jqXHR, textStatus, errorThrown) ->
          alert errorThrown
      return false
    e.preventDefault()
  #-- выбытие застрахованного по П025
  #=======================================================================================================
  $("div#customers_customer_info").on "click","#customers_search_025", (event) ->
    e = event || window.event
    if confirm('Вы уверенны что этот человек выбыл ?')
      $.ajax
        type: "GET"
        url: @href
        success: (response) ->
          if response is 200
            $('.row')
              .before '<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">×</button>Застрахованное лицо выведено из действующих</div>'
          else
            $('.row')
              .before '<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">×</button>Не удалось выполнить операцию</div>'
    e.preventDefault()



  #-- выбытие застрахованного по П022
  #======================================================================================================= 
  $("div#customers_customer_info").on "focus","#dp_date_of_death", (e) ->
    $(@).datepicker
      showOn: 'focus'
      beforeShow: (input) ->
        $(input).css('background-color', "#ff9")
      onSelect: (dateText, inst) ->
        $(@).css('background-color', "")
        $("#customers_search_022").removeAttr 'disabled'

  $("div#customers_customer_info").on "click","#customers_search_022", (e) ->  
    $.ajax
      type: "POST"
      dataType: 'json'
      url: '/customers/death_of_customer'
      data:
        date: $("#dp_date_of_death").datepicker 'getDate'
        id: $("#customers_search_customer_id").val()
      success: (response) ->
        $("#deathModal").modal 'hide'
        if response is 200
          $('.row')
            .before '<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">×</button>Застрахованное лицо выведено из действующих</div>'
        else
          $('.row')
            .before '<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">×</button>Не удалось выполнить операцию</div>'
      error: (jqXHR, textStatus, errorThrown) -> alert errorThrown
  
  #-- выдача на руки полиса по П060
  #=======================================================================================================
  $("div#customers_customer_info").on "focus","#dp_date_begin", (e) ->
  #$("#dp_date_begin").bind "focus", ->
    $(@).datepicker
      showOn: 'focus'
      beforeShow: (input) ->
        $(input).css('background-color', "#ff9")
      onSelect: (dateText, inst) ->
        $(@).css('background-color', "")
        $("#customers_search_060").removeAttr 'disabled'

  $("div#customers_customer_info").on "click","#customers_search_060", (e) ->
  #$("#customers_search_060").bind "click", ->
    $.ajax
      type: "POST"
      dataType: 'json'
      url: '/customers/edit_polis'
      data:
        date: $("#dp_date_begin").datepicker 'getDate'
        id: $("#customers_puts_customer_id").val()
      success: (response) ->
        $("#edit_polisModal").modal 'hide'
        if response is 200
          $('.row')
            .before '<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">×</button>Данные о выдаче полиса успешно сохранились.</div>'
        else
          $('.row')
            .before '<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">×</button>Не удалось выполнить операцию.</div>'
      error: (jqXHR, textStatus, errorThrown) -> alert errorThrown

  #-- подгружает формы на странице http://localhost:3000/customers/{id}/edit
  #========================================================================================================
  $("#customers_edit_doc, #customers_edit_person, #customers_edit_addres_g").click ->
    $.ajax
      type: "GET"
      dataType: "html"
      url: @href
      success: (data) ->
        $("div.person-block").remove()
        $("div.page-body").append data
        
      error: (jqXHR, textStatus, errorThrown) -> alert errorThrown
    return false
  #========================================================================================================
  $("div.page-body").on "change",'input[name="vizit[rpolis]"]:radio', (e) ->
  #$('input[name="vizit[rpolis]"]:radio').bind "change", ->
    if @value is "2"
      $('div.control-group:gt(8)').not($('div.control-group:gt(14)')).hide("slow")
    else
      $('div.control-group:gt(8)').not($('div.control-group:gt(14)')).show("slow")
  #========================================================================================================
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
  
  $("div.page-body").on "focus","#addres_g_npname", (e) ->
    $(@).autocomplete
     source:(request,response) ->
      $.ajax 
       url: '/okatos', 
       dataType: "json", 
       data: 
         term: request.term.toUpperCase() 
       success: (data) ->response $.map data, (item)-> label: item.namenpt, value: item.namenpt, okato: item.okato,
     minLength: 2,
     open: -> $(@).removeClass("ui-corner-all").addClass("ui-corner-top"), 
     close: -> $(@).removeClass("ui-corner-top").addClass("ui-corner-all"),
     select: (event, ui) -> 
      $("#addres_g_okato").val ui.item.okato

  $("div.page-body").on "focus","#addres_g_ul", (e) ->
    $(@).typeahead
      source: (query,process) ->
        $.ajax
          url: '/streets',
          data:
            term: query.toUpperCase()
          success: (data) ->
            process data

  $("div#customers_customer_info").on "click","#fack_pr_delete", (event) ->
    e = event || window.event
    if confirm('Вы уверенны ?')
      $.ajax
        type: "DELETE"
        url: @href
        success: (data, textStatus, jqXHR) ->
          $('.row').before data
        error: (jqXHR, textStatus, errorThrown) ->
          alert errorThrown
      return false
      #alert $(@).parent().tagName
    e.preventDefault()

  $("div#customers_customer_info").on "click","#ter_pr_delete", (event) ->
    e = event || window.event
    if confirm('Вы уверенны ?')
      $.ajax
        type: "DELETE"
        url: @href
        success: (data, textStatus, jqXHR) ->
          $('.row').before data
        error: (jqXHR, textStatus, errorThrown) ->
          alert errorThrown
      return false
      #alert $(@).parent().tagName
    e.preventDefault()

  #$("#edit_addres_g").bind 'click', ->
  #  setTimeout(-> 
  #    $("div#atlhModal").modal
  #      show: true
  #      keyboard: false
  #      backdrop: false 
  #   3000)