# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
 
  $.datepicker.setDefaults($.extend($.datepicker.regional["ru"]))
  
  $("#ops_search, #ats_search").attr disabled: 'disabled'
  
  $("#dp-fild").datepicker
    beforeShow: (input) ->
     $(input).css('background-color', "#ff9")
    onSelect: (dateText, inst) ->
     $(@).css('background-color', "")
     $("#ops_search").removeAttr 'disabled'
  
  $("#ops_search").click ->
   $(@).attr disabled: 'disabled'
   options=
    type: "GET",
    dataType: 'json',
    url: "/ops/create_links",
    data: (date: $("#dp-fild").datepicker('getDate')),
    success: (response) ->
     if response == 201
      $('.row')
       .before '<div class="alert alert-info"><button type="button" class="close" data-dismiss="alert">×</button>Нет файлов для этой даты</div>'
     else
      links response
   
   $.ajax(options)
#    .attr("disabled","disabled");
   return false
   
  links = (response) ->
   $.each response,
    (i,item)->
     $('<a>'+item.name+'</a>').attr 
      href: '/ops/files?id='+item.id+'&name='+item.name
     .appendTo "#ops_links"
  
  $("#dp-fild-ats").datepicker
    beforeShow: (input) -> $(input).css 'background-color', "#ff9"
    onSelect: (dateText, inst) -> 
      $(@).css 'background-color', "" 
      $("#ats_search").removeAttr 'disabled'
  
  $("#ats_search").click ->
    _date = {date: $("#dp-fild-ats").datepicker 'getDate'}
    $(@).attr disabled: 'disabled'
    $('<a id="upload_ats">Скачать файл XML</a>').attr
      href: '/ats/create_links?' + $.param _date
    .appendTo "#ats_links" 
  
  # $("#upload_ats").live "click", ->
  #   $.ajax
  #     type: "POST",
  #     dataType: 'json',
  #     url: '/ats/create_links',
  #     data: (date: $("#dp-fild-ats").datepicker('getDate')),
  #     success: (response) ->
  #       $('.row')
  #         .before '<div class="alert alert-info"><button type="button" class="close" data-dismiss="alert">×</button>Нет файлов для этой даты</div>'
  #   return false 
  
  # $("#ats_search").click ->
  #   $(@).attr disabled: 'disabled'
  #   $.ajax
  #       type: "GET",
  #       dataType: 'json',
  #       url: "/ats/create_links",
  #       data: (date: $("#dp-fild-ats").datepicker('getDate')),
  #       success: (response) ->
  #         if response == 201
  #           $('.row')
  #             .before '<div class="alert alert-info"><button type="button" class="close" data-dismiss="alert">×</button>Нет файлов для этой даты</div>'
  #         else
  #           links_ats response  
  #   return false
  # 
  # links_ats = (response) ->
  #   $.each response, (i,item) ->
  #     $('<a>'+item.name+'</a>').attr 
  #      href:'/ats/files?id='+item.id+'&name='+item.name
  #     .appendTo "#ats_links"
