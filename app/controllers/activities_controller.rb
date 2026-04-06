class ActivitiesController < ApplicationController
  before_action :require_login
  before_action :set_habit

  def create
    @activity = @habit.activities.build(activity_params)
    @activity.position = @habit.activities.count

    respond_to do |format|
      if @activity.save
        format.turbo_stream
        format.html { redirect_to habit_path(@habit) }
      else
        format.html { redirect_to habit_path(@habit), alert: @activity.errors.full_messages.to_sentence }
      end
    end
  end

  def update
    @activity = @habit.activities.find(params[:id])
    @activity.update(activity_params)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to habit_path(@habit) }
    end
  end

  def destroy
    @activity = @habit.activities.find(params[:id])
    @activity.destroy
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

  def activity_params
    params.require(:activity).permit(:title, :position)
  end
end
