# encoding: utf-8
module VizitsHelper
  def method_podachi_zayvlenia
    method_arey = [["лично",1],["через официальный сайт ТФОМС",3],["через единый портал государственных услуг",4]]
      return method_arey
  end
  def vibor_zamena_smo
    vibor_arey = [["первичный выбор СМО",1],["замена СМО в соответствии с правом замены раз в год",2],
		  ["замена СМО в связи со сменой места жительства застрахованного",3],["замена СМО в связи с прекращением действия договора",4]]
    return vibor_arey
  end
  def prichina_zameni_polisa
    r_arey = [["изменение реквизитов",1],["установление ошибочности сведений",2],
		  ["ветхость и непригодность полиса",3],["утрата ранее выданного полиса",4],
		  ["окончание срока действия полиса",5]]
    return r_arey
  end
  def forma_polisa
    f_arey = [["не требует изготовления полиса",0],["бумажный бланк",1],["пластиковая карта",2],["в составе УЭК",3]]
    return f_arey
  end
  def month_in_rus_string(d_date)
    m = d_date.month
    
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
    
    return _m
  end
end
