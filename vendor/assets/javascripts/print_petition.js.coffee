jQuery ->
	fam = $("span#pp_fio").attr 'fam'
	im = $("span#pp_fio").attr 'im'
	ot = $("span#pp_fio").attr 'ot'

	rsmo = $("table#pp_rsmo").attr 'myvalue'
	$("table#pp_rsmo td.selected").each ->
		if @id is rsmo
			$(@).text "✔"
	fpolis = $("table#pp_fpolis").attr 'myvalue'
	$("table#pp_fpolis td.selected").each ->
		if @id is fpolis
			$(@).text "✔"
	status = $("table#pp_status").attr 'myvalue'
	$("table#pp_status td.selected").each ->
		if @id is status
			$(@).text "✔"
	enp = $("table#pp_enp").attr 'myvalue'
	if enp is undefined
		$("td#nil_enp").text "✔"
	else
		$("table#pp_enp td.enp").each (i)->
			$(@).text enp.substr(i,1)
	w = $("table#pp_w").attr 'myvalue'
	$("table#pp_w td.enp").each ->
		if @id is w
			$(@).text "✔"
	addres_g_indx = $("table#pp_addres_g_indx").attr 'myvalue'
	if addres_g_indx isnt undefined
		$("table#pp_addres_g_indx td.enp").each (i)->
			$(@).text addres_g_indx.substr(i,1)
	addres_g_bomg = $("table#pp_addres_g_bomg").attr 'myvalue'
	if addres_g_bomg is "1"
		$("table#pp_addres_g_bomg td.enp").text "✔"
	addres_p_indx = $("table#pp_addres_p_indx").attr 'myvalue'
	if addres_p_indx isnt undefined
		$("table#pp_addres_p_indx td.enp").each (i)->
			$(@).text addres_p_indx.substr(i,1)
	representative_parent = $("table#pp_representative_parent").attr 'myvalue'
	if representative_parent isnt undefined
		$("table#pp_representative_parent td.enp").each ->
			if @id is representative_parent
				$(@).text "✔"
	$.ajax
	  type: "POST"
	  dataType: 'text/html'
	  crossDomain: true
	  contentType: 'application/x-www-form-urlencoded; charset=windows-1251'
	  url: "http://www.delphikingdom.com/padeg_online.asp"
	  data: $.param(fioFName:im, fioLName:fam, fioMName:ot, nPadeg:2, send:on, Gender:2, Submit: "Проверить")
	  xhrFields: withCredentials: true
	  success: (data, textStatus, jqXHR) ->
		alert "ok"
	  error: (jqXHR, textStatus, errorThrown) ->
	  	alert "error"
	

	#//utf8 to 1251 converter (1 byte format, RU/EN support only + any other symbols) by drgluck
	#// utf8_decode = (aa) ->
	#// 	bb = '', c = 0
	#	
	#// function utf8_decode (aa) {
	#//     var bb = '', c = 0;
	#//     for (var i = 0; i < aa.length; i++) {
	#//         c = aa.charCodeAt(i);
	#//         if (c > 127) {
	#//             if (c > 1024) {
	#//                     c = 1016;
	#//                 } else if (c == 1105) {
	#                     c = 1032;
	#                 }
	#                 bb += String.fromCharCode(c - 848);
	#             }
	#         } else {
	#             bb += aa.charAt(i);
	#         }
	#     }
	#     return bb;
	# }
	