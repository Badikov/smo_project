# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

file = File.open("ate.txt")
    i = 0
      file.each do |line|
      	if  i > 0
          kdate,	nameate = line.chomp("\n").split("\t")
          @ate = Ate.new({kdate: kdate, nameate: nameate})
          @ate.save!
        end
        i += 1
      end
file.close