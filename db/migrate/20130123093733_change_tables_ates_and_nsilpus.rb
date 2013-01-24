class ChangeTablesAtesAndNsilpus < ActiveRecord::Migration
  def up
    change_table :ates do |t|
      t.remove :id
      t.rename :kdate, :id
    end
    change_table :nsilpus do |t|
      t.rename :kdate, :ate_id
      t.index :ate_id
    end
  end

  
end
