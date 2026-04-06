class GoalsController < ApplicationController
  before_action :require_login
  before_action :set_habit

  def create
    @goal = @habit.build_goal(goal_params)
    if @goal.save
      redirect_to habit_path(@habit)
    else
      redirect_to habit_path(@habit), alert: @goal.errors.full_messages.to_sentence
    end
  end

  def update
    @goal = @habit.goal
    @goal.update(goal_params)
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

  def goal_params
    params.require(:goal).permit(:description)
  end
end
