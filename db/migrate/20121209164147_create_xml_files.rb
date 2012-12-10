class CreateXmlFiles < ActiveRecord::Migration
  def change
    create_table :xml_files do |t|

      t.timestamps
    end
  end
end
