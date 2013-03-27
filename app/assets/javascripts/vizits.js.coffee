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
     pervichniy_vibor_smo.show("slow")
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
     zamena_smo.show("slow")
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
      $("form#new_vizit div.optional:eq(2)").show("slow")
      $('label[for="vizit_insurance_polis_npolis"]').text 'Номер временного свидетельства'
      $("#vizit_fpolis option").each () ->
        $(@)
          .removeAttr('disabled')
          .removeAttr('selected')
      $("#vizit_fpolis option[value=0]").attr disabled: "disabled"
      $("#vizit_fpolis option[value=1]").attr selected: "selected"
      #$("#vizit_fpolis option[value=1]").attr selected: 'selected'  
      #$("#vizit_fpolis option[value=0]").attr disabled: 'disabled'
      

      #$("#vizit_fpolis option[value=0]").removeAttr 'selected'
      #$("#vizit_fpolis option[value=0]").attr disabled: 'disabled'
      #$("#vizit_fpolis option[value=1]").removeAttr 'disabled'
      #$("#vizit_fpolis option[value=1]").attr selected: "selected"
     else
      $("form#new_vizit div.optional:eq(2)").hide()
      $('label[for="vizit_insurance_polis_npolis"]').text 'Номер бланка полиса единого образца'
      $("#vizit_fpolis option").each () ->
        $(@)
          .removeAttr('disabled')
          .removeAttr('selected')
      
      #$("#vizit_fpolis option[value=0]").removeAttr 'disabled'
      $("#vizit_fpolis option[value=0]").attr selected: "selected"
      #$("#vizit_fpolis option[value=1]").removeAttr 'selected'
      $("#vizit_fpolis option[value=1]").attr disabled: 'disabled'
 
 $('#vizit_petition').click ->
   if @checked  # выбрано подано ходатайство
    petition.hide()
    $('form#new_vizit div.form-actions')
       .before '<div class="control-group string optional error"><label class="string optional control-label" for="vizit_dvizit">Дата временного свидетельства</label><div class="controls"><input id="vizit_dvizit" class="string optional span2" type="text" size="20" name="vizit[dvizit]"><span class="help-inline">введите дату ходатайства</span></div></div>'
   else
     petition.show("slow")
     # $('label[for="vizit_dvizit"]').remove()
     # $('div.controls:last').remove()
     $('div.control-group:last').remove()
 
 $("#new_vizit").keydown (event) -> 
   e = event || window.event
   if e.keyCode is 13
    return false
 
 $("form#new_vizit").on "focus","#vizit_dvizit", (e) ->
 #$("#vizit_dvizit").bind "focus", ->
   $(@).datepicker
    showOn: 'focus'
    onSelect: (dateText, inst) -> 
      $('div.control-group:last').removeClass 'error'
      $('div.control-group:last>div.controls>span.help-inline').remove()
 
 
 #--------------------------------------------------------------------------------------------
 #----------Модальные окна территориального и фактического прикрепления к лечебному учреждению
 #--------------------------------------------------------------------------------------------



 $("#customers_customer_info").on 'show', '#atl_fakt_hModal', ->
   $("label[for^='at']").remove()
   $("#atl_fakt_hModal select#at_kdatemu")
    .select2
      placeholder: "Территории Кемеровской области"
    .change ->
      _kdate = $(@).val()
      _lpus = $("#atl_fakt_hModal select#at_kdmu")
      _lpus.html ''
      $.ajax
        type: "GET"
        dataType: 'json'
        url: '/nsilpus.json'
        data:
          kdate: _kdate
        success: (data) -> 
          $.map data, (item)-> _lpus.append '<option value=' + item.kdlpu + '>' + item.kdlpu + '---' + item.namelpu + '</option>'
        error: (jqXHR, textStatus, errorThrown) -> alert errorThrown
      _lpus
        .change ->
          $("#atl_fakt_hModal input#at_date_b")
            .datepicker
              maxDate: "d"
              onSelect: (dateText, inst) ->
                $("#atl_fakt_hModal button#create_at_fakt")
                  .click ->
                    $(@).attr disabled: 'disabled'
                    $.ajax
                      type: "POST"
                      url: $("#atl_fakt_hModal form#new_at").attr 'action'
                      data: $("#atl_fakt_hModal form#new_at").serialize()
                      success: (data, textStatus, jqXHR) ->
                        $('.row').before data
                        $("#atl_fakt_hModal").modal 'hide'
                      error: (jqXHR, textStatus, errorThrown) ->
                    return false
                  .removeAttr 'disabled'
   $("#atl_fakt_hModal select#at_kdmu").select2
    placeholder: "Лечебные учреждения"


#----------------------------------------------------
#  это работает
 $("form#new_at select#at_kdatemu")
  .select2
    placeholder: "Территории Кемеровской области"
  .change ->
    _kdate = $(@).val()
    _lpus = $("div#fackt select#at_kdmu")
    _lpus.html ''
    $.ajax
      type: "GET"
      dataType: 'json'
      url: '/nsilpus.json'
      data:
        kdate: _kdate
      success: (data) -> 
        $.map data, (item)-> _lpus.append '<option value=' + item.kdlpu + '>' + item.kdlpu + '---' + item.namelpu + '</option>' 
        $("div#fackt select#at_kdmu").removeAttr 'disabled'
        $("div#fackt div#s2id_at_kdmu").removeClass "select2-container-disabled"
      error: (jqXHR, textStatus, errorThrown) -> alert errorThrown
 $("div#fackt select#at_kdmu")
  .change ->
    $("form#new_at input#at_date_b")
      .datepicker
        changeMonth: true
        changeYear: true
        maxDate: "d"
        onSelect: (dateText, inst) ->
          $("div#fackt input#fack")
            .click ->
              $.ajax
                type: "POST"
                url: $("div#fackt form#new_at").attr 'action'
                data: $("div#fackt form#new_at").serialize()
                success: (data, textStatus, jqXHR) ->
                  $('.row').before data
                  $("div#fackt").hide 'slow'
                error: (jqXHR, textStatus, errorThrown) ->
              return false
            .removeAttr 'disabled'
      .removeAttr 'disabled'

 $("form#new_at select#at_kdmu")
  .select2
    placeholder: "Лечебные учреждения"
 $("div#terr select#at_kdmu")
  .change ->
    $("div#terr input#ter")
      .click ->
        $.ajax
          type: "POST"
          url: $("div#terr form#new_at").attr 'action'
          data: $("div#terr form#new_at").serialize()
          success: (data, textStatus, jqXHR) ->
            $('.row').before data
            $("div#terr").hide 'slow'
          error: (jqXHR, textStatus, errorThrown) ->
        return false
      .removeAttr 'disabled'
 $("label[for^='at']").remove()
#===========================================================================================================



 $("div#customers_customer_info").delegate "div#atlhModal",'show', ->
   $("#kdmu").select2()
   $("#kdmu").focus()
 $("div#customers_customer_info").delegate "select#kdmu",'change', ->
   $("#create_at_t").removeAttr 'disabled'
 $("div#customers_customer_info").delegate "button#create_at_t",'click', ->
   $.ajax
     type: "POST"
     url: '/ats'
     data:
       person_id: $("#create_at_t_person_id").val()
       kdatemu: $("#create_at_t_kdatemu").val()
       kdmu: $("#kdmu option:selected").attr 'value'
     success: (data, textStatus, jqXHR) ->
       $("#create_at_t").attr 'disabled'
       $("div#atlhModal").modal 'hide'
       
       if textStatus is "success"
         $('.row').before data
       else
         $('.row')
           .before '<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">×</button>Не удалось выполнить операцию</div>'
     error: (jqXHR, textStatus, errorThrown) -> alert errorThrown
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