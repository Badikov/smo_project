module PeopleHelper
  def status_resource
    statuses =[]
    
    file = File.open( 'status.txt' )
    i = 0
      file.each do |line|
        code, name = line.chomp("\n").split("\t")
        
        if i > 3
          statuses << [name, code]
        end
        i = i+1 
      end
    file.close
    return statuses
  end
end
