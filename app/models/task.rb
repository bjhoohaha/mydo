class Task < ApplicationRecord
  validates :title, :description, :status, presence:true
  acts_as_list
end
