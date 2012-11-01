class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :fam
      t.string :im
      t.string :ot
      t.integer :w
      t.date :dr
      t.integer :true_dr
      t.string :c_oksm
      t.string :ss
      t.string :phone
      t.string :email
      t.string :fiopr
      t.string :contact
      t.date :ddeath

      t.timestamps
    end
  end
end
