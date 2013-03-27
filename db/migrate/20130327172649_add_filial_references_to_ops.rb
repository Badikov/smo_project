class AddFilialReferencesToOps < ActiveRecord::Migration
  class Op < ActiveRecord::Base
  end
  class User < ActiveRecord::Base
  end
  def change
    add_column :ops, :filial_id, :integer
    Op.reset_column_information
    
    #to update all ops with filial_id
    Op.all.each do |op|
      
        user = User.find_by_id(op.user_id)
        if user
          op.update_column(:filial_id, user.filial_id)
        end
      
    end
    add_index :ops, :filial_id
    add_index(:ops, [:filial_id, :person_id], :unique => true)
  end
end
