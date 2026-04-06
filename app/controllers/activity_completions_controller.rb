class ActivityCompletionsController < ApplicationController
  before_action :require_login
  before_action :set_habit

  def create
    activity = @habit.activities.find(params[:activity_id])
    activity.activity_completions.find_or_create_by(
      completed_on: Date.current,
      user: current_user
    )

    @activities = @habit.activities.ordered
    @today_completions = ActivityCompletion
      .where(activity_id: @activities.pluck(:id), completed_on: Date.current)
      .pluck(:activity_id).to_set

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to habit_path(@habit) }
    end
  end

  def destroy
    activity = @habit.activities.find(params[:activity_id])
    completion = activity.activity_completions.find_by(
      completed_on: Date.current,
      user: current_user
    )
    completion&.destroy

    @activities = @habit.activities.ordered
    @today_completions = ActivityCompletion
      .where(activity_id: @activities.pluck(:id), completed_on: Date.current)
      .pluck(:activity_id).to_set

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to habit_path(@habit) }
    end
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
    authorize @habit, :update?
  end
end
