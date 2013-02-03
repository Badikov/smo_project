class CreateForeigners < ActiveRecord::Migration
  def change
    create_table :foreigners do |t|
      t.string :ig_doctype, :limit => 100
      t.string :ig_docser, :limit => 20
      t.string :ig_docnum, :limit => 20
      t.date :ig_docdate
      t.string :ig_name_vp, :limit => 150
      t.date :ig_startdate
      t.date :ig_enddate
      t.references :person

      t.timestamps
    end
    add_index :foreigners, :person_id
    
    docs = Doc.where("ig_docdate is not null")
    docs.each do |doc|
      foreigner = Foreigner.new(ig_doctype: doc.ig_doctype, ig_docnum: doc.ig_docnum,ig_docdate: doc.ig_docdate, ig_name_vp: doc.ig_name_vp, ig_startdate: doc.ig_startdate, ig_enddate: doc.ig_enddate, person_id: doc.person_id)
      foreigner.save
    end
  end
end
