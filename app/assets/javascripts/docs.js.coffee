jQuery ->
  doc_style_ = () ->
   $("#doc_doctype option").css "color","#999999"
   $("#doc_doctype option[value=14], #doc_doctype option[value=3]").css "color","#0D0534"
   #$("#doc_doctype option[value=14]").attr selected: "selected"
  window.doc_style_=doc_style_
       