class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @habits = current_user.habits.active.ordered
    earliest = @habits.minimum(:start_date) || Date.current
    start = [ earliest, Date.current - 29.days ].max
    @days = (start..Date.current).to_a.reverse

    @completions = current_user.habit_logs
                               .where(completed_on: @days)
                               .pluck(:habit_id, :completed_on)
                               .group_by(&:first)
                               .transform_values { |v| v.map(&:last).to_set }
  end
end
