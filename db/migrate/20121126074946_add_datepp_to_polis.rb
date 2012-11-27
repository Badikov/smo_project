class AddDateppToPolis < ActiveRecord::Migration
  def change
    add_column :polis, :datepp, :date
  end
end
