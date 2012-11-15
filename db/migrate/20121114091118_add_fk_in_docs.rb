class AddFkInDocs < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE docs
        ADD CONSTRAINT fk_docs_tipdocs
        FOREIGN KEY (doctype)
        REFERENCES tipdocs(id)
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE docs
        DROP FOREIGN KEY fk_docs_tipdocs
    SQL
  end
end
