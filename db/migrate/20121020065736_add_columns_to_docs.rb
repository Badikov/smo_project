class AddColumnsToDocs < ActiveRecord::Migration
  def change
    add_column :docs, :ig_doctype, :string
    add_column :docs, :ig_docser, :string
    add_column :docs, :ig_docnum, :string
    add_column :docs, :ig_docdate, :date
    add_column :docs, :ig_name_vp, :string
    add_column :docs, :ig_startdate, :date
    add_column :docs, :ig_enddate, :date
  end
end
