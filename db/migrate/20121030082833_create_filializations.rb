class CreateFilializations < ActiveRecord::Migration
  def change
    create_table :filializations, :id =>false do |t|

      t.references :user
      t.references :filial
    end
    add_index :filializations, :user_id
    add_index :filializations, :filial_id
  end
end
