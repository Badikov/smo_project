# encoding: utf-8
class DocsController < ApplicationController
  def index
    statuses =[]
      file = File.open("a_05.txt")
        i = 0
          file.each do |line|
      	    if  i > 0
              # statuses = line.chomp("\n").split("\t")

             
              id_fl,kdatelpu_t,kdlpu_t,date_lpu_t,date_lpu,kdatelpu_f,kdlpu_f,date_modif = line.chomp("\n").split("\t")
              
              person = Op.find_by_id(id_fl.to_i)
              
                person_id = person.person_id
                created_at= person.created_at
                updated_at= date_modif.to_date#DateTime.now.beginning_of_day - 1.day
                dtt = date_lpu_t.slice(6,4) + "-" + date_lpu_t.slice(3,2) + "-" + date_lpu_t.slice(0,2)
                dt = DateTime.strptime(dtt, "%Y-%m-%d")
              
                _type    = "T"
                kdatemu = kdatelpu_t.to_i
                kdmu    = kdlpu_t.to_i
                date_z  = person.created_at
                date_b  = dtt
                
                @at_t = At.new({created_at: created_at ,date_b: date_b, type_at: _type, date_z: date_z, kdatemu: kdatemu, kdmu: kdmu, person_id: person_id, updated_at: updated_at})
                @at_t.save
                
              if !kdlpu_f.blank? and !kdatelpu_f.blank?
                __type    = "F"
                _kdatemu = kdatelpu_f.to_i
                _kdmu    = kdlpu_f.to_i
                _date_z  = person.created_at
                _date_b  = date_lpu.to_date
                @at_f = At.new({created_at: created_at ,date_b: _date_b, type_at: __type, 
                  date_z: _date_z, kdatemu: _kdatemu, kdmu: _kdmu, person_id: person_id, updated_at: updated_at})
                @at_f.save
              end

              
              
             
               
                 # statuses << @at_t
              # [id_fl.to_i,date_uvoln,kdatelpu_t.to_i,kdlpu_t.to_i,date_lpu_t,date_lpu,kdatelpu_f,kdlpu_f,date_modif, date_z]
            end
            i = i + 1
          end
        
      file.close
    render json: status
  end
  def show
    (1..962).each do |n| 
      @at = At.find_by_id(n)
      @at.destroy
      
    end
    render json: status
  end
    
    
end
