
 window.onload =->
  gender = document.getElementById("print_vizit_doc_gender")
  id_gender = document.getElementById("print_vizit_person")
  cls = id_gender.className
#   removeClass id_gender, id_gender.className 
  if gender.innerHTML isnt '1'
#   removeClass = (id_genderv,cls) ->
   regexp = new RegExp('\\b'+cls+'\\b')
#   el=document.getElementById(id_gender)
   id_gender.className=id_gender.className.replace(regexp,'')
   id_gender.className='woman'
  gender.style.visibility="hidden"
   
   
  