class WeeklyMilestone < ApplicationRecord
  belongs_to :goal

  validates :week_number, inclusion: { in: 1..4 }
  validates :week_number, uniqueness: { scope: :goal_id }
  validates :description, presence: true

  scope :ordered, -> { order(:week_number) }
end
