class Task < ApplicationRecord
  validates :title, :description, :status, :color, presence:true
  acts_as_list
end
