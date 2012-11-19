class RemoveColumnFromTableOps < ActiveRecord::Migration
  def up
    
    remove_column :ops, :doc_id
    remove_column :ops, :old_person_id
    remove_column :ops, :old_doc_id
    remove_column :ops, :addres_g_id
    remove_column :ops, :addres_p_id
    remove_column :ops, :vizit_id
    remove_column :ops, :insurance_id
    remove_column :ops, :personb_id
  end

  
end
