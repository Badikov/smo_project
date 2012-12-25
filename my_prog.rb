#!/usr/bin/env ruby


file = File.open( "Okato" )
 file.each { |line|  
   sim = { kdnpt: "", namenpt: "", kdobl: "", kdate: "", okato: "" }
   st = line
   st = st.chomp("\n")
   ar = []
   ar = st.split("\t") 
   
  i = 0
  sim.each{|k,v| 
	  sim[k] = ar[i] 
	  i+= 1 }
   p sim
 }
  
file.close

statuses =[]
    s_oksm = ""
    file = File.open("nsilpu.txt")
    i = 0
      file.each do |line|
        if  i > 0
          kdlpu,kdate,namelpu,kdvzr_det,userid,date_modif,kdlpu_ur,kdate_ur,stat,kdtype = line.chomp("\n").split("\t")
          
          @nsilpu = Nsilpu.new(:kdate => kdate , :kdate_ur => kdate_ur, :kdlpu => kdlpu, :kdlpu_ur => kdlpu_ur, :kdtype => kdtype, :namelpu => namelpu, :status => nil )
          # statuses = @nsilpu
          # [kdlpu,kdate,namelpu,kdvzr_det,userid,date_modif,kdlpu_ur,kdate_ur,stat,kdtype]
          @nsilpu.save
        end
        i+= 1
      end
    file.close
    render json: status