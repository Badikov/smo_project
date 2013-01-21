#!/usr/bin/ruby

module Smo
  
  
  def Smo.padeg(fam,name,otch,gender)
    require "net/http"
    require 'uri'
    uri = URI.parse('http://www.delphikingdom.com/padeg_online.asp')
    req = Net::HTTP::Post.new(uri.path)
    
     # parameters =  {'Gender' => 3, 'fioFName' => 'ÅËÈÇÀÂÅÒÀ', 'fioLName' => 'ÄÈÊ', 'fioMName' => 'ÂÀÄÈÌÎÂÍÀ', 'nPadeg' => 2, 'send' => 'on'}
    parameters = {'Gender' => gender + 1,'fioFName' => name.encode('Windows-1251','UTF-8'), 'fioLName' => fam.encode('Windows-1251','UTF-8'), 'fioMName' => otch.encode('Windows-1251','UTF-8'), 'nPadeg' => 2, 'send' => 'on'}
    # par ='fioLName=%C4%C8%CA&fioFName=%C5%CB%C8%C7%C0%C2%C5%D2%C0&fioMName=%C2%C0%C4%C8%CC%CE%C2%CD%C0&Gender=3&Appointment=&Office=&nPadeg=2&Submit=%CF%F0%EE%E2%E5%F0%E8%F2%FC&send=on'
    
    # req.set_form_data(parameters)
    
    res = Net::HTTP.post_form(uri, parameters)
    
    
    
    # $KCODE = "ASCII-8BIT"
    output = res.body.force_encoding('Windows-1251').encode('UTF-8') #+ "русские буквы"#.encode('Windows-1251', invalid: :replace, undef: :replace)
        # output.encode!( 'UTF-8', 'Windows-1251' )
    # output = res.read_body.force_encoding('UTF-8')
    # logger.debug {output}
    tokens = HTML::Tokenizer.new(output)
    tags = nil
    while token = tokens.next
      node = HTML::Node.parse(nil, 0, 0, token, false)
      
      if node.tag? and node.closing != :close and node.match :tag => "input",:attributes => { :name => "P_FIO" } 
        tags = node.attributes["value"]
        # tags = tags.unpack('U'*tags.length) 
        # tags = tags.encode( 'UTF-8', 'Windows-1251' )
      end
    end
    return UnicodeUtils.upcase(tags)
  end
  
  
end