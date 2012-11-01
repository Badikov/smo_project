class CreatePersonbs < ActiveRecord::Migration
  def change
    create_table :personbs do |t|
      t.string :type
      t.binary :photo
      t.references :person

      t.timestamps
    end
    add_index :personbs, :person_id
  end
end
