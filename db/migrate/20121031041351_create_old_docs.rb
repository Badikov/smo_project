class CreateOldDocs < ActiveRecord::Migration
  def change
    create_table :old_docs do |t|
      t.string :doctype
      t.string :docser
      t.string :docnum
      t.date :docdate
      t.string :name_vp
      t.string :mr
      t.references :person

      t.timestamps
    end
    add_index :old_docs, :person_id
  end
end
