jQuery ->
	_gender = $("div#gender").attr 'myvalue'
	if _gender is "1"
   		$("div#gender").css "left":"30mm"
   	else
   		$("div#gender").css "left":"58mm"
   
  