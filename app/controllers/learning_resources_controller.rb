class LearningResourcesController < ApplicationController
  before_action :require_login
  before_action :set_habit

  def create
    @resource = @habit.learning_resources.build(resource_params)
    @resource.position = @habit.learning_resources.where(week_number: @resource.week_number).count

    respond_to do |format|
      if @resource.save
        format.turbo_stream
        format.html { redirect_to habit_path(@habit) }
      else
        format.html { redirect_to habit_path(@habit), alert: @resource.errors.full_messages.to_sentence }
      end
    end
  end

  def update
    @resource = @habit.learning_resources.find(params[:id])

    if params.dig(:learning_resource, :completed_at) == "toggle"
      @resource.update!(completed_at: @resource.completed_at.present? ? nil : Time.current)
    else
      @resource.update(resource_params)
    end

    @resources_by_week = @habit.learning_resources.ordered.group_by(&:week_number)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to habit_path(@habit) }
    end
  end

  def destroy
    @resource = @habit.learning_resources.find(params[:id])
    @resource.destroy

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

  def resource_params
    params.require(:learning_resource).permit(:title, :url, :resource_type, :week_number, :position, :notes)
  end
end
