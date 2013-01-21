class CreateAtes < ActiveRecord::Migration
  def change
    create_table :ates do |t|
      t.integer :kdate, :null => false
      t.string :nameate, :limit => 128

    end
  end
end
