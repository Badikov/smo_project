class CreateTipdocs < ActiveRecord::Migration
  def change
    create_table :tipdocs do |t|
      t.string :iddoc
      t.string :docname
      t.string :docser
      t.string :docnum
      t.date :datebeg
      t.date :dateend

      t.timestamps
    end
  end
end
