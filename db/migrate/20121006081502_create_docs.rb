class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :doctype
      t.string :docser
      t.string :docnum
      t.date :docdate
      t.string :name_vp
      t.string :mr
      t.references :person

      t.timestamps
    end
    add_index :docs, :person_id
  end
end
