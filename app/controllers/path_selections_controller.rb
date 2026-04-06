class PathSelectionsController < ApplicationController
  before_action :require_login
  before_action :set_habit

  def create
    if @habit.path_type.present?
      redirect_to habit_path(@habit), alert: t("paths.already_selected")
      return
    end

    path_type = params[:path_type]
    unless Habit::PATH_TYPES.include?(path_type)
      redirect_to habit_path(@habit), alert: t("paths.invalid")
      return
    end

    @habit.update!(path_type: path_type)
    redirect_to habit_path(@habit), notice: t("paths.selected")
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
    authorize @habit, :update?
  end
end
