class New < ActiveRecord::Migration
  def up
    remove_column :docs, :ig_doctype
    remove_column :docs, :ig_docser
    remove_column :docs, :ig_docnum
    remove_column :docs, :ig_docdate
    remove_column :docs, :ig_name_vp
    remove_column :docs, :ig_startdate
    remove_column :docs, :ig_enddate
  end
end
