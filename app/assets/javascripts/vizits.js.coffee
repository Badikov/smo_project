# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
 $.datepicker.setDefaults($.extend($.datepicker.regional["ru"]))

 hidens = $("form#new_vizit div.optional:eq(0), form#new_vizit div.optional:eq(5)")

 pervichniy_vibor_smo = $("form#new_vizit div.optional:eq(2), form#new_vizit div.optional:eq(9)")
 
 zamena_smo = $("form#new_vizit div.optional:eq(3),form#new_vizit div.optional:eq(6)")

 petition = $("form#new_vizit div.optional:eq(1),form#new_vizit div.optional:eq(7),form#new_vizit div.optional:eq(8)")
 
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
     $('label[for="vizit_insurance_attributes_polis_attributes_npolis"]').text 'Номер бланка полиса единого образца'
     $('#vizit_insurance_attributes_polis_attributes_spolis').val ''
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
     $('#vizit_insurance_attributes_enp').val ''
     $('label[for="vizit_insurance_attributes_polis_attributes_npolis"]').text 'Номер временного свидетельства'
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
      $("form#new_vizit div.optional:eq(3)").show()
      $('label[for="vizit_insurance_attributes_polis_attributes_npolis"]').text 'Номер временного свидетельства'
      $("#vizit_fpolis option[value=0]").removeAttr 'selected'
      $("#vizit_fpolis option[value=0]").attr disabled: 'disabled'
      $("#vizit_fpolis option[value=1]").removeAttr 'disabled'
      $("#vizit_fpolis option[value=1]").attr selected: "selected"
     else
      $("form#new_vizit div.optional:eq(3)").hide()
      $('label[for="vizit_insurance_attributes_polis_attributes_npolis"]').text 'Номер бланка полиса единого образца'
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