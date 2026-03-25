class HabitLogsController < ApplicationController
  before_action :set_habit

  def create
    date = Date.parse(params[:date] || Date.current.to_s) rescue Date.current

    @log = @habit.habit_logs.find_or_create_by(
      completed_on: date,
      user: current_user
    )

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def destroy
    date = Date.parse(params[:date] || Date.current.to_s) rescue Date.current

    @log = @habit.habit_logs.find_by(completed_on: date, user: current_user)
    @log&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
    authorize @habit, :update?
  end
end
