class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.string :ter_st
      t.integer :enp
      t.string :ogrnsmo
      t.integer :erp
      t.references :vizit

      t.timestamps
    end
    add_index :insurances, :vizit_id
  end
end
