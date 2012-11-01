class CreateSubektis < ActiveRecord::Migration
  def change
    create_table :subektis do |t|
      t.string :kod_tf
      t.string :subname
      t.string :kod_okato

      t.timestamps
    end
  end
end
