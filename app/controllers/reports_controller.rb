class ReportsController < ApplicationController
  layout "report"
  def today
    @ops = Op.includes([:user,:person => [{:vizit => {:insurance => :polis}},:doc]]).new_today_active
    
    respond_to do |format|
    format.html
    #format.json { render json: ProductsDatatable.new(view_context) }
    end
  end
  
  def jobs
    @ops = Op.includes([:user,:person => [{:vizit => {:insurance => :polis}}]]).jobs_today
  end
  
  def age14
    @people = Person.get_passport
  end
  def foreigners
    @foreigners = Foreigner.includes(:person => {:vizit => {:insurance => :polis}}).all_foreigners
  end
  
  def yesterday
    @ops = Op.new_yesterday
  end
  def date_at
    @dt = params[:date]
    @ops = Op.includes([:user,:person => [{:vizit => {:insurance => :polis}},:doc]]).new_date_at(params[:date].to_date)
  end
  def jobs_date_at
    @dt = params[:date]
    @ops = Op.includes([:user,:person => [{:vizit => {:insurance => :polis}}]]).jobs_date_at(params[:date].to_date)
  end
  def people_group_counter
    @child0_4 = Person.joins(:op).where(['ops.active= ? and people.dr > ?', true, DateTime.current.months_ago(60)]).group(:w)
    logger.debug { @child0_4.count }
    @child5_17 = Person.joins(:op)
    .where(['ops.active= ? and people.dr > ? and people.dr <= ?', true, DateTime.current.months_ago(216), DateTime.current.months_ago(60)])
    .group(:w)
    @male18_59 = Person.joins(:op)
    .where(['ops.active= ? and people.dr > ? and people.dr <= ?', true, DateTime.current.months_ago(720), DateTime.current.months_ago(216)])
    .group(:w)
    @female18_54 = Person.joins(:op)
    .where(['ops.active= ? and people.dr > ? and people.dr <= ?', true, DateTime.current.months_ago(660), DateTime.current.months_ago(216)])
    .group(:w)
    @oldmale_60 = Person.joins(:op).where(['ops.active= ? and people.dr <= ?', true, DateTime.current.months_ago(720)]).group(:w)
    @oldfemale_55 = Person.joins(:op).where(['ops.active= ? and people.dr <= ?', true, DateTime.current.months_ago(660)]).group(:w)
  end
  def error_vizit
    @people = Person.error_vizit
  end
end
