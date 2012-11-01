class CreateFilials < ActiveRecord::Migration
  def change
    create_table :filials do |t|
      t.string :title

      t.timestamps
    end
  end
end
