class Filialization < ActiveRecord::Base
  belongs_to :user
  belongs_to :filial
  # attr_accessible :title, :body
end
