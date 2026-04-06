class DailyCheckin < ApplicationRecord
  belongs_to :habit
  belongs_to :user

  validates :checked_on, presence: true
  validates :habit_id, uniqueness: { scope: :checked_on }
  validates :progress_score, inclusion: { in: 1..5 }

  after_save    :ensure_habit_log
  after_destroy :remove_habit_log

  private

  def ensure_habit_log
    habit.habit_logs.find_or_create_by(completed_on: checked_on, user: user)
  end

  def remove_habit_log
    habit.habit_logs.find_by(completed_on: checked_on)&.destroy
  end
end
