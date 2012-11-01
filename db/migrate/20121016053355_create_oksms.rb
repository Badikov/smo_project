class CreateOksms < ActiveRecord::Migration
  def change
    create_table :oksms do |t|
      t.string :kod
      t.string :name11
      t.string :alfa2
      t.string :alfa3

      t.timestamps
    end
  end
end
