class CreatePolis < ActiveRecord::Migration
  def change
    create_table :polis do |t|
      t.integer :vpolis
      t.string :npolis
      t.string :spolis
      t.date :dbeg
      t.date :dend
      t.date :dstop
      t.references :insurance

      t.timestamps
    end
    add_index :polis, :insurance_id
  end
end
