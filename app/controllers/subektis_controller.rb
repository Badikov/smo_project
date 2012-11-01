class SubektisController < ApplicationController
def index
      file = File.open( "Subekti" )
      file.each { |line|  
      sim = { kod_tf: "", subname: "", kod_okato: "" }
      st = line
      st = st.chomp("\n")
      ar = []
      ar = st.split("\t") 
      
      i = 0
      sim.each{|k,v| 
	      sim[k] = ar[i] 
	      i+= 1 }
      @sub = Subekti.create(sim)
    }
      
    file.close
    @sub = Subekti.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sub }
    end
  end
end
