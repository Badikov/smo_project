jQuery ->
	rsmo = $("table#pp_rsmo").attr 'myvalue'
	$("table#pp_rsmo td.selected").each ->
		if @id is rsmo
			$(@).text "✔"
	fpolis = $("table#pp_fpolis").attr 'myvalue'
	$("table#pp_fpolis td.selected").each ->
		if @id is fpolis
			$(@).text "✔"
	rpolis = $("table#pd_rpolis").attr 'myvalue'
	$("table#pd_rpolis td.selected").each ->
		if @id is rpolis
			$(@).text "✔"
	rpolis_ = $("table#pd_rpolis1").attr 'myvalue'
	if rpolis_ is "3" or rpolis_ is "4"
	  $("table#pd_rpolis1 td#2").text "✔"
	else
	  if rpolis_ is "1" or rpolis_ is "2" or rpolis_ is "5"
	  	$("table#pd_rpolis1 td#1").text "✔"
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
	w_old = $("table#pp_w_old").attr 'myvalue'
	$("table#pp_w_old td.enp").each ->
		if @id is w_old
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
	rnname = $("span#pp_rnname").attr 'myval'
	if rnname is ""
		$("span#pp_npname").text ''
	else
		$("span#pp_city").text ''
	rnname_p = $("span#pp_p_rnname").attr 'myval'
	if rnname_p is ""
		$("span#pp_p_npname").text ''
	else
		$("span#pp_p_city").text ''
	