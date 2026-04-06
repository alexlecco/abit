class ActivityCompletion < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  validates :completed_on, presence: true
  validates :activity_id, uniqueness: { scope: :completed_on }

  after_create  :sync_habit_log
  after_destroy :sync_habit_log

  private

  def sync_habit_log
    # Don't retroactively alter historical logs (e.g. when deleting an activity)
    return if completed_on < Date.current

    habit = activity.habit
    all_activity_ids = habit.activities.pluck(:id)
    return if all_activity_ids.empty?

    completed_ids = ActivityCompletion
      .where(activity_id: all_activity_ids, completed_on: completed_on)
      .pluck(:activity_id).to_set

    all_complete = all_activity_ids.all? { |id| completed_ids.include?(id) }

    if all_complete
      habit.habit_logs.find_or_create_by(completed_on: completed_on, user: user)
    else
      habit.habit_logs.find_by(completed_on: completed_on)&.destroy
    end
  end
end
