# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#new_person").formToWizard submitButton:'0856'
  
  $("#person_true_dr, #person_ss").tooltip()
  
  
  
  $("#pet_dog").attr("checked", "checked")
  
  $('#person_addres_g_attributes_bomg').removeAttr 'checked'
  
  adres = $("div#step2 div.string:gt(8)").add("div#step2 div.select:last")
  
  content = $("div#step2 div.string, div#step2 div.date, div#step2 div.select")
  
  okato = $("div#step2 div.string:eq(1), div#step2 div.string:eq(10)")
  
#   okato.hide()
  
  ig = $("div#step1 div.control-group:gt(5)")
       
  ig.hide()
  
  if $("#pet_dog").attr("checked")
    $(adres).hide()
  
  $("#person_addres_g_attributes_bomg").click -> 
  #$("#person_addres_g_attributes_bomg").click ->
    if @checked
      content.hide()
    else
      content.show()
#       okato.hide()
      $("#pet_dog").attr checked: 'checked'
      adres.hide()

      
  $("#pet_dog").click ->
    if @checked
      adres.hide()
    else
      adres.show()
#       okato.hide()
  
  #выбор вид на жительство для инюграждан
  $("#person_doc_attributes_doctype").change ->
    $("#person_doc_attributes_doctype option:selected").each ->
      if @value is "9"
       ig.show()
      else
       ig.hide()
 
    
  $('#person_c_oksm').typeahead
    source: (query,process) ->
      $.ajax
        url: '/oksms',
        data:
          term: query.toUpperCase()
        success: (data) ->
          process data
    
  # $('#person_c_oksm').change () -> alert('Handler for .change() called.')
  $('#person_addres_g_attributes_ul').autocomplete
    source: $('#person_addres_g_attributes_ul').data('autocomplete-source'),
    minLength: 3
    
  $('#person_addres_p_attributes_ul').autocomplete
    source: $('#person_addres_p_attributes_ul').data('autocomplete-source'),
    minLength: 3
    
#   $('#person_doc_attributes_mr').autocomplete
#     source: $('#person_doc_attributes_mr').data('autocomplete-source')
   
#   
     
  $('#person_addres_p_attributes_npname, #person_addres_g_attributes_npname').autocomplete
     source:(request,response) ->
      $.ajax 
       url: '/okatos', 
       dataType: "json", 
       data: 
         maxRows: 12,
         term: request.term.toUpperCase(), 
         featureClass: "P", 
         style: "full", 
       success: (data) ->response $.map data, (item)-> label: item.namenpt, value: item.namenpt, okato: item.okato,
     minLength: 2,
     open: -> $(@).removeClass("ui-corner-all").addClass("ui-corner-top"), 
     close: -> $(@).removeClass("ui-corner-top").addClass("ui-corner-all"),
     select: (event, ui)-> okato_ @,ui.item.okato

  okato_ = (field,_okato) ->
   _id = field.id
   _id = _id.slice(0,27).concat("okato")
   $("input#" + _id).attr value: _okato
      
  $("#new_person").keydown (event) -> 
   e = event || window.event
   if e.keyCode is 13
    return false
      
    
  #console.log(states) .toUpperCase()