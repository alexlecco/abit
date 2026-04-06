class Goal < ApplicationRecord
  belongs_to :habit
  has_many :weekly_milestones, dependent: :destroy

  validates :description, presence: true

  def milestone_for_week(n)
    weekly_milestones.find_by(week_number: n)
  end
end
