# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
 hidens = $("form#new_vizit div.string:lt(2), form#new_vizit div.integer:first")
 pervichniy_vibor_smo = $("form#new_vizit div.optional:eq(5),form#new_vizit div.optional:eq(9),form#new_vizit div.optional:eq(10),form#new_vizit div.optional:eq(11),form#new_vizit div.optional:eq(14),form#new_vizit div.optional:eq(15)")
 zamena_smo = $("form#new_vizit div.optional:eq(6),form#new_vizit div.optional:eq(7),form#new_vizit div.optional:eq(8),form#new_vizit div.optional:eq(9),form#new_vizit div.optional:eq(10),form#new_vizit div.optional:eq(11),form#new_vizit div.optional:eq(13)")
 hidens.hide()
 pervichniy_vibor_smo.hide()
 $('#vizit_insurance_attributes_erp').removeAttr 'checked'
 $("#vizit_rsmo option[value=1]").attr selected: true
 $("#vizit_fpolis option[value=1]").attr selected: true
 $('#vizit_insurance_attributes_erp').click ->
   if @checked
     pervichniy_vibor_smo.show()
     zamena_smo.hide()
     $("#vizit_rsmo option[value=2]").attr selected: true
     $("#vizit_rpolis option[value='']").attr selected: true
     $("#vizit_fpolis option[value=0]").attr selected: true
   else
     zamena_smo.show()
     pervichniy_vibor_smo.hide()
     $("#vizit_rsmo option[value=1]").attr selected: true
     $("#vizit_fpolis option[value=1]").attr selected: true
 
 $('#vizit_rpolis').change ->
   $("#vizit_rpolis option:selected").each ->
     if @value != ""
      $("form#new_vizit div.optional:eq(6),form#new_vizit div.optional:eq(7),form#new_vizit div.optional:eq(8)").show()
      $("#vizit_fpolis option[value=1]").attr selected: true
     else
      $("form#new_vizit div.optional:eq(6),form#new_vizit div.optional:eq(7),form#new_vizit div.optional:eq(8)").hide()
      $("#vizit_fpolis option[value=0]").attr selected: true
      

      

  
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