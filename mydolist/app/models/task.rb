class Task < ApplicationRecord
  validates :title, :description, :status, presence:true
  validates :status, inclusion: {in:['In Progress', 'Awaiting Reply', 'Pending', 'Completed']}
  validates :check, acceptance:true
  validates :color, inclusion: {in: ["", "#EDF6F7","#F0EAD6", "#92A8D1", "#E8B5CE", "#FFD662"]}
  validate :valid_date

  private

  def valid_date
    unless due_date.is_a?(Date)
      if due_date.blank?
      else
        errors.add(:due_date, "must be a valid date")
      end
    end
  end

end
