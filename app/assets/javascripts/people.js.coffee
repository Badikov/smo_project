# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#new_person").formToWizard submitButton:'0856'
  
  $("#person_true_dr, #person_ss").tooltip()
  
  $("#pet_dog").attr("checked", "checked")
  
  $('#person_addres_g_bomg').removeAttr 'checked'
  
  $("form#new_person select#person_doc_doctype option[value=14]").attr selected: "selected"

  $("#person_addres_g_subj option[value=32000]").attr selected: "selected"
  
  adres = $("div#step2 div.string:gt(8)").add("div#step2 div.select:last")
  
  # content = $("div#step2 div.string, div#step2 div.date, div#step2 div.select")
  content = $("div#step2 div.control-group:gt(5)").not($("div#step2 div.control-group:eq(11)"))
  
  okato = $("div#step2 div.string:eq(1), div#step2 div.string:eq(10)")
  
#   okato.hide()
  
  ig = $("div#step1 div.control-group:gt(5)")

       
  ig.hide()
  
  if $("#pet_dog").attr("checked")
    $(adres).hide()
  
  $("#person_addres_g_bomg").click ->
    if @checked
      content.hide()
      $("#pet_dog").attr checked: 'checked'
    else
      content.show()
#       okato.hide()
      $("#pet_dog").attr checked: 'checked'
      adres.hide()

      
  $("#pet_dog").click ->
    if @checked
      adres.hide()
      adres.each ->
        $(@).find("input, select")
        .val ''
    else
      adres.show()
#       okato.hide()
  
  
  $('#person_addres_g_ul, #person_addres_p_ul').typeahead
    source: (query,process) ->
      $.ajax
        url: '/streets',
        data:
          term: query.toUpperCase()
        success: (data) ->
          process data
  
      
  $("#person_c_oksm").typeahead
    source: (query,process) ->
      $.ajax
        url: '/oksms',
        data:
          term: query.toUpperCase()
        success: (data) ->
          process data
        
  #выбор вид на жительство для инюграждан  
  $('#person_c_oksm').change () -> 
    _c_oksm = $(@).val()
    if _c_oksm.length is 3
      if _c_oksm isnt 'RUS'
        ig.show()
        _remove_selected()
        $("#person_doc_doctype option[value=9]").attr selected: "selected"
      else
        ig.hide()
        _remove_selected()
        $("#person_doc_doctype option[value=14]").attr selected: "selected"


  $('#person_addres_p_npname, #person_addres_g_npname, #addres_g_npname, #addres_p_npname').autocomplete
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
     select: (event, ui)-> okato_ @,ui.item.okato

  okato_ = (field,_okato) ->
   _id = field.id
   #_id = _id.slice(0,16).concat("okato")
   _id = _id.replace('npname','okato')
   $("input#" + _id).attr value: _okato
      
  $("#new_person").keydown (event) -> 
   e = event || window.event
   if e.keyCode is 13
    return false

  $("a#step0Next").click ->
    #console.log($("div#step0 input[name^='person']").serializeArray())
    #return false
    $.ajax
      url: '/people/checking',
      dataType: "json", 
      data: ($("div#step0 input[name^='person'], div#step0 select[name^='person']").serializeArray()),
      success: (data, textStatus, jqXHR) ->
        if data.length > 0
          _person = data[0]
          $('.row')
            .before '<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">×</button>' + _person.fam + ' ' + _person.im + ' ' + _person.ot + ', ' + _person.dr + ' г. рожд. уже есть в нашей базе.</div>'
      error: (jqXHR, textStatus, errorThrown) ->
        alert errorThrown
    kinder_()
  
  kinder_ = () ->
    y_ = $("select#person_dr_1i option:selected").attr 'value'
    m_ = $("select#person_dr_2i option:selected").attr 'value'
    d_ = $("select#person_dr_3i option:selected").attr 'value'
    dr_ = new Date(y_, m_-1, d_)
    cur_ = new Date()
    age = Math.floor (cur_-dr_)/(365.25 * 24 * 60 * 60 * 1000)
    if 0 <= age < 14
      _remove_selected()
      $("#person_doc_doctype option[value=3]").attr selected: "selected"
      $("#person_doc_doctype option[value=14]").attr disabled: 'disabled'
      $("#person_doc_docser").attr value: 'II-ЛО'
 
  $('*[data-poload]').bind 'click', ->
    e = $(@)
    e.unbind 'click'
    $.get e.data('poload'), (d) ->
      e.popover
        content: d
        html: true
        placement: 'bottom'
      .popover 'show'
  $('#application_brand').popover
  
  _remove_selected = () ->
    $("#person_doc_doctype option:selected").each ->
      $(@).removeAttr 'selected'
      
     
  #console.log(states) .toUpperCase()