class HabitLog < ApplicationRecord
  belongs_to :habit
  belongs_to :user

  validates :completed_on, presence: true
  validates :habit_id, uniqueness: { scope: :completed_on }

  after_create :update_habit_streaks
  after_destroy :update_habit_streaks

  private

  def update_habit_streaks
    habit.update_streaks!
  end
end
