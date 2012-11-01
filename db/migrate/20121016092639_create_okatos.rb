class CreateOkatos < ActiveRecord::Migration
  def change
    create_table :okatos do |t|
      t.string :kdnpt
      t.string :namenpt
      t.string :kdobl
      t.string :kdate
      t.string :okato

      t.timestamps
    end
  end
end
