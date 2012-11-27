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
end
