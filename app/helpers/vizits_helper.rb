# encoding: utf-8
module VizitsHelper
  def date_in_rus_string(d_date)
    y = d_date.year.to_s
    m = d_date.month
    d = d_date.day.to_s
    case m
      when  1  
	_m = "января" 
      when  2  
	_m = "февраля"
      when  3  
	_m = "марта"
      when  4  
	_m = "апреля"
      when  5  
	_m = "мая"
      when  6  
	_m = "июня"
      when  7  
	_m = "июля"
      when  8  
	_m = "августа"
      when  9  
	_m = "сентября"
      when  10  
	_m = "октября"
      when  11  
	_m = "ноября"
      when  12  
	_m = "декабря"
      else
	_m = ""
    end
    str = "#{d.size == 1 ? "0" + d : d}   #{_m}     #{y}"
    return str
  end
end
