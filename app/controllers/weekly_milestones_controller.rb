class WeeklyMilestonesController < ApplicationController
  before_action :require_login
  before_action :set_habit

  def create
    @goal = @habit.goal
    @milestone = @goal.weekly_milestones.build(milestone_params)
    respond_to do |format|
      if @milestone.save
        format.turbo_stream
        format.html { redirect_to habit_path(@habit) }
      else
        format.html { redirect_to habit_path(@habit), alert: @milestone.errors.full_messages.to_sentence }
      end
    end
  end

  def update
    @goal = @habit.goal
    @milestone = @goal.weekly_milestones.find(params[:id])
    @milestone.update(milestone_params)
    if @milestone.achieved? && @milestone.achieved_at.nil?
      @milestone.update_columns(achieved_at: Time.current)
    end
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

  def milestone_params
    params.require(:weekly_milestone).permit(
      :week_number, :description, :acceptance_criteria,
      :achieved, :reflection
    )
  end
end
