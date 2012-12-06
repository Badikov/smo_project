# encoding: utf-8
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
  def priznok_date
    priznok = [[ 'Дата достоверна', 1 ],['Известны достоверно только месяц и год рождения', 2], 
    ['Известен достоверно только год рождения', 3]]
    return priznok
  end
end
