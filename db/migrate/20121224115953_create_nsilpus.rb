class CreateNsilpus < ActiveRecord::Migration
  def change
    create_table :nsilpus do |t|
      t.integer :kdlpu
      t.string :kdate
      t.string :namelpu
      t.integer :kdlpu_ur
      t.integer :kdate_ur
      t.integer :status
      t.integer :kdtype

      
    end
  end
end
