class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments, :id => false do |t|
      t.integer :user_id
      t.integer :role_id

      
    end
  end
end
