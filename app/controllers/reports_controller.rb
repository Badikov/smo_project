class ReportsController < ApplicationController
  layout "report"
  def today
    @ops = Op.new_today_active
    
    respond_to do |format|
    format.html
    #format.json { render json: ProductsDatatable.new(view_context) }
    end
  end
  
  def jobs
    @ops = Op.jobs_today
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
end
