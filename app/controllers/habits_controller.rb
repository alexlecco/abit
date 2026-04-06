class HabitsController < ApplicationController
  before_action :require_login
  before_action :set_habit, only: [ :show, :edit, :update, :destroy ]

  def index
    redirect_to root_path
  end

  def show
    case @habit.path_type
    when "activities"
      @activities = @habit.activities.ordered
      @today_completions = ActivityCompletion
        .where(activity_id: @activities.pluck(:id), completed_on: Date.current)
        .pluck(:activity_id).to_set
    when "learning"
      @resources_by_week = @habit.learning_resources.ordered.group_by(&:week_number)
      @current_week = @habit.current_week_number
    when "goals"
      @goal = @habit.goal
      @milestones = @goal&.weekly_milestones&.ordered || []
      @current_week = @habit.current_week_number
      @current_milestone = @goal&.milestone_for_week(@current_week)
      @today_checkin = @habit.daily_checkins.find_by(checked_on: Date.current)
    end
  end

  def new
    @habit = current_user.habits.build
  end

  def create
    @habit = current_user.habits.build(habit_params)
    @habit.start_date = Date.current
    @habit.position = current_user.habits.count

    if @habit.save
      redirect_to root_path, notice: t("habits.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @habit.update(habit_params)
      redirect_to root_path, notice: t("habits.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @habit.update(active: false)
    redirect_to root_path, notice: t("habits.archived")
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:id])
    authorize @habit
  end

  def habit_params
    params.require(:habit).permit(:name, :description, :color)
  end
end
