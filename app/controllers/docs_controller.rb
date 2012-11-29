# encoding: utf-8
class DocsController < ApplicationController
  def index
    statuses =[]
      file = File.open("atlist29.txt")
        i = 0
          file.each do |line|
      	    if  i > 0
              _type = ""
              id_fl,date_uvoln,kdatelpu_t,kdlpu_t,date_lpu_t,date_lpu,kdatelpu_f,kdlpu_f,date_modif = line.chomp("\n").split("\t")
              person = Op.find_by_id(id_fl.to_i)
              if kdlpu_f.blank? and kdatelpu_f.blank?
                _type    = "T"
                kdatemu = kdatelpu_t.to_i
                kdmu    = kdlpu_t.to_i
                date_z  = person.created_at
                date_b  = date_lpu_t.to_date
              else
                _type    = "F"
                kdatemu = kdatelpu_f.to_i
                kdmu    = kdlpu_f.to_i
                date_z  = person.created_at
                date_b  = date_lpu.to_date
              end
              person_id = person.person_id
              
              created_at= person.created_at
              updated_at= '28.11.2012'
              
             
               @at = At.new({created_at: created_at ,date_b: date_b, 
                 type_at: _type, date_z: date_z, kdatemu: kdatemu, kdmu: kdmu, person_id: person_id, updated_at: updated_at})
               @at.save
               # statuses << @at
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
