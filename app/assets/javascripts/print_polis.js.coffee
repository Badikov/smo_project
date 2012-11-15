
 window.onload =->
  gender = document.getElementById("print_vizit_doc_gender")
  id = document.getElementById("print_vizit_person")
  cls = id.className
#   removeClass id, id.className 
  if gender.innerHTML isnt '0'
#   removeClass = (id,cls) ->
   regexp = new RegExp('\\b'+cls+'\\b')
#   el=document.getElementById(id)
   id.className=id.className.replace(regexp,'')
   id.className='woman'
  gender.style.visibility="hidden"
   
   
  