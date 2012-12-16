# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
 $.datepicker.setDefaults($.extend($.datepicker.regional["ru"]))

 pervichniy_vibor_smo = $("form#new_vizit div.optional:eq(1), form#new_vizit div.optional:eq(7)")
 
 zamena_smo = $("form#new_vizit div.optional:eq(2),form#new_vizit div.optional:eq(4)")

 petition = $("form#new_vizit div.optional:eq(0),form#new_vizit div.optional:eq(5),form#new_vizit div.optional:eq(6)")
  
 pervichniy_vibor_smo.hide()
 $("label[for='vizit_insurance_erp'], label[for='vizit_petition'],label[for='vizit_rpolis']").hide()
 $('#vizit_insurance_erp').removeAttr 'checked' #!!!!!!!начальные настройки на первичный выбор смо
 $("#vizit_fpolis option[value=0]").attr disabled: "disabled"
 $("#vizit_fpolis option[value=1]").attr selected: "selected"
 $("#vizit_rsmo option[value=1]").attr selected: "selected"
 $("#vizit_rsmo option").each () ->
    if $(@).val() > 1
      $(@).attr disabled: 'disabled'
 

 #!!!!!!!!!!!!!!!!!!!!!!!! клик по флажку Зарегестрирован и ЕРП
 $('#vizit_insurance_erp').click ->
   if @checked #!!!!!!!!!!!!!! замена смо
     pervichniy_vibor_smo.show()
     zamena_smo.hide()
     $('label[for="vizit_insurance_polis_npolis"]').text 'Номер бланка полиса единого образца'
     $('#vizit_insurance_polis_spolis').val ''
     $("input#vizit_rsmo option[value=1]").removeAttr 'selected'

     $("#vizit_rsmo option").each () ->
        $(@).removeAttr 'disabled'
     $("#vizit_rsmo option[value=2]").attr selected: "selected"
     $("#vizit_rsmo option[value=1]").attr disabled: 'disabled'

     
     $("#vizit_fpolis option").each () ->
        if $(@).val() > 0
          $(@).attr disabled: 'disabled'
        else
          $(@).removeAttr 'disabled'
     $("#vizit_fpolis option[value=1]").removeAttr 'selected'
     $("#vizit_fpolis option[value=0]").attr selected: "selected"
          
   else #!!!!!!!!!!!!!!!!!!!!! первичный выбор смо
     zamena_smo.show()
     pervichniy_vibor_smo.hide()
     $('#vizit_insurance_enp').val ''
     $('label[for="vizit_insurance_polis_npolis"]').text 'Номер временного свидетельства'
     $("#vizit_rpolis").removeAttr 'checked'

     $("#vizit_rsmo option").each () ->
        $(@).attr disabled: 'disabled'
     $("#vizit_rsmo option[value=1]").removeAttr 'disabled'
     $("#vizit_rsmo option[value=2]").removeAttr 'selected'
     $("#vizit_rsmo option[value=1]").attr selected: "selected"
     
     $("#vizit_fpolis option").each () ->
        $(@).removeAttr 'disabled'
     $("#vizit_fpolis option[value=0]").attr disabled: 'disabled'
     $("#vizit_fpolis option[value=0]").removeAttr 'selected'
     $("#vizit_fpolis option[value=1]").attr selected: "selected"
     
      
 $('#vizit_rpolis').click ->
     if @checked
      $("form#new_vizit div.optional:eq(2)").show()
      $('label[for="vizit_insurance_polis_npolis"]').text 'Номер временного свидетельства'
      $("#vizit_fpolis option[value=0]").removeAttr 'selected'
      $("#vizit_fpolis option[value=0]").attr disabled: 'disabled'
      $("#vizit_fpolis option[value=1]").removeAttr 'disabled'
      $("#vizit_fpolis option[value=1]").attr selected: "selected"
     else
      $("form#new_vizit div.optional:eq(2)").hide()
      $('label[for="vizit_insurance_polis_npolis"]').text 'Номер бланка полиса единого образца'
      $("#vizit_fpolis option[value=0]").removeAttr 'disabled'
      $("#vizit_fpolis option[value=0]").attr selected: "selected"
      $("#vizit_fpolis option[value=1]").removeAttr 'selected'
 
 $('#vizit_petition').click ->
   if @checked  # выбрано подано ходатайство
    petition.hide()
    $('form#new_vizit div.form-actions')
       .before '<label class="string optional control-label" for="vizit_dvizit">Дата временного свидетельства</label><div class="controls"><input id="vizit_dvizit" class="string optional span2" type="text" size="20" name="vizit[dvizit]"></div>'
   else
     petition.show()
     $('label[for="vizit_dvizit"]').remove()
     $('div.controls:last').remove()
 
 $("#new_vizit").keydown (event) -> 
   e = event || window.event
   if e.keyCode is 13
    return false
 
 $("#vizit_dvizit").live "focus", ->
   $("#vizit_dvizit").datepicker()
  
 
    
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