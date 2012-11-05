class CreateAts < ActiveRecord::Migration
  def change
    create_table :ats do |t|
      t.string :type
      t.integer :kdatemu
      t.integer :kdmu
      t.date :date_z
      t.date :date_b
      t.date :date_e
      t.references :person

      t.timestamps
    end
    add_index :ats, :person_id
  end
end
