# encoding: utf-8
module CustomersHelper
  def method_podachi_zayvlenia(arg1)
    case arg1
      when "1"
        res = 'лично'
      when "2"
        res = 'через представителя'
      when "3"
        res = 'через официальный сайт ТФОМС'
      when "4"
        res = 'через единый портал государственных услуг'
      else
        res = nil
    end
    return res
  end
  def vibor_smo(arg)
    case arg
    when 1
      vibor = "первичный выбор СМО"
    when 2
      vibor = "замена СМО в соответствии с правом замены"
    when 3
      vibor = "замена СМО в связи со сменой места жительства"
    when 4
      vibor = "замена СМО в связи с прекращением действия договора"
    else
      vibor = nil
    end
       return vibor
  end
  def method(arg)
    case arg
    when "1"
      method = "лично"
    when "2"
      method = "через представителя"
    when "3"
      method = "через официальный сайт ТФОМС"
    when "4"
      method = "через единый портал государственных услуг"
    else
      method = nil
    end
      return method
  end
  def formapolisa(arg)
    case arg
    when 0
      forma = "не требует изготовления полиса"
    when 1
      forma = "бумажный бланк"
    when 2
      forma = "пластиковая карта"
    when 3 
      forma = "в составе УЭК"
    else
      forma =nil
    end
      return forma
  end
  def zamena_polisa(arg)
    case arg
    when 1
      res = "изменение реквизитов"
    when 2
      res = "установление ошибочности сведений"
    when 3
      res = "ветхость и непригодность полиса"
    when 4
      res = "утрата ранее выданного полиса"
    when 5
      res = "окончание срока действия полиса"
    else
      res = nil
    end
    return res
  end
end
