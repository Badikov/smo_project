# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
 hidens = $("form#new_vizit div.optional:eq(0), form#new_vizit div.optional:eq(5)")

 pervichniy_vibor_smo = $("form#new_vizit div.optional:eq(2), form#new_vizit div.optional:eq(9)")
 
 zamena_smo = $("form#new_vizit div.optional:eq(3),form#new_vizit div.optional:eq(4)")
 
 hidens.hide()
 pervichniy_vibor_smo.hide()
 $("label[for='vizit_insurance_attributes_erp'], label[for='vizit_petition']").hide()
 $('#vizit_insurance_attributes_erp').removeAttr 'checked' #!!!!!!!начальные настройки на первичный выбор смо
 $("#vizit_fpolis option[value=0]").attr disabled: 'disabled'
 $("#vizit_rsmo option[value=1]").attr selected: "selected"
 $("#vizit_rsmo option[value=2]").attr disabled: 'disabled'
 $("#vizit_rsmo option[value=3]").attr disabled: 'disabled'
 $("#vizit_rsmo option[value=4]").attr disabled: 'disabled'

 $("#vizit_fpolis option[value=1]").attr selected: "selected"
 #!!!!!!!!!!!!!!!!!!!!!!!! клик по флажку Зарегестрирован и ЕРП
 $('#vizit_insurance_attributes_erp').click ->
   if @checked #!!!!!!!!!!!!!! замена смо
     pervichniy_vibor_smo.show()
     zamena_smo.hide()
     $("input#vizit_rsmo option[value=1]").removeAttr 'selected'
     $("#vizit_rsmo option[value=1]").attr disabled: 'disabled'
     $("#vizit_rsmo option[value=2]").removeAttr 'disabled'
     $("#vizit_rsmo option[value=3]").removeAttr 'disabled'
     $("#vizit_rsmo option[value=4]").removeAttr 'disabled'
     $("#vizit_rsmo option[value=2]").attr selected: "selected"
     $("#vizit_rpolis option[value='']").attr selected: "selected"
     $("#vizit_fpolis option[value=1]").removeAttr 'selected'
     $("#vizit_fpolis option[value=0]").removeAttr 'disabled'
     $("#vizit_fpolis option[value=0]").attr selected: "selected"
     $("#vizit_fpolis option[value=1]").attr disabled: 'disabled'
     $("#vizit_fpolis option[value=2]").attr disabled: 'disabled'
     $("#vizit_fpolis option[value=3]").attr disabled: 'disabled'
     
   else #!!!!!!!!!!!!!!!!!!!!! первичный выбор смо
     zamena_smo.show()
     pervichniy_vibor_smo.hide()
     $("#vizit_rpolis option[value='']").removeAttr 'selected'
     $("#vizit_rsmo option[value=2]").removeAttr 'selected'
     $("#vizit_rsmo option[value=1]").removeAttr 'disabled'
     $("#vizit_rsmo option[value=1]").attr selected: "selected"
     $("#vizit_rsmo option[value=2]").attr disabled: 'disabled'
     $("#vizit_rsmo option[value=3]").attr disabled: 'disabled'
     $("#vizit_rsmo option[value=4]").attr disabled: 'disabled'
     $("#vizit_fpolis option[value=0]").removeAttr 'selected'
     $("#vizit_fpolis option[value=1]").attr selected: "selected"
     $("#vizit_fpolis option[value=0]").attr disabled: 'disabled'
     $("#vizit_fpolis option[value=1]").removeAttr 'disabled'
     $("#vizit_fpolis option[value=2]").removeAttr 'disabled'
     $("#vizit_fpolis option[value=3]").removeAttr 'disabled'
 
 $('#vizit_rpolis').change ->
   $("#vizit_rpolis option:selected").each ->
     if @value != ""
      $("form#new_vizit div.optional:eq(3),form#new_vizit div.optional:eq(4)").show()
      $("#vizit_fpolis option[value=1]").attr selected: "selected"
      $("#vizit_fpolis option[value=0]").removeAttr 'selected'
      $("#vizit_fpolis option[value=0]").attr disabled: 'disabled'
     else
      $("form#new_vizit div.optional:eq(3),form#new_vizit div.optional:eq(4)").hide()
      $("#vizit_fpolis option[value=0]").removeAttr 'disabled'
      $("#vizit_fpolis option[value=0]").attr selected: "selected"
      $("#vizit_fpolis option[value=1]").removeAttr 'selected'
      
 
 $("#new_vizit").keydown (event) -> 
   e = event || window.event
   if e.keyCode is 13
    return false
 
#  $('a.print').click (event) ->
#    params = "_blank,menubar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes"
#    newWind = window.open('about:blank', '', params)
#    $.get @href,(response) -> newWind.document.body.innerHTML = response
 
   
  
#   
#   petition.attr checked: 'checked'
#   
#   sel = $("div.select:gt(0)").not("div.select:last")
#   if petition.attr('checked')
     
#     sel.hide()
#     
#   petition.change ->
#     if @checked
#       sel.hide()
#     else
#       sel.show()
#       