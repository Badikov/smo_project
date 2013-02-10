# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

file = File.open("i_09.txt")
    i = 0
      file.each do |line|
      	if  i > 0
          id_fl,fam,name,otch,ser,num,raz_v,razresh_d,razresh_f,dateendpol = line.chomp("\n").split("\t")
          op = Op.find_by_id(id_fl)
          if op
            foreng = op.person.build_foreigner({ ig_doctype: "Разрешение на временное проживание",
              ig_docser: ser, ig_docnum: num, ig_docdate:razresh_d,ig_name_vp:raz_v,ig_startdate:razresh_d,ig_enddate:razresh_f})
            foreng.save
            if ser.blank?
              polis = op.person.vizit.insurance.polis
              polis.attributes = {dstop: dateendpol}
              polis.save(:validate => false)
            end
            puts i
          end
        end
        i += 1
      end
file.close