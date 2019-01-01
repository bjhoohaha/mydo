class Task < ApplicationRecord
  validates :title, :description, :status, presence:true
  validates :color, allow_blank: true, presence: false

  acts_as_list
end
