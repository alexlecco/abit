class HabitsController < ApplicationController
  before_action :set_habit, only: [ :edit, :update, :destroy ]

  def index
    redirect_to root_path
  end

  def new
    @habit = current_user.habits.build
  end

  def create
    @habit = current_user.habits.build(habit_params)
    @habit.start_date = Date.current
    @habit.position = current_user.habits.count

    if @habit.save
      redirect_to root_path, notice: "Chain created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @habit.update(habit_params)
      redirect_to root_path, notice: "Chain updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @habit.update(active: false)
    redirect_to root_path, notice: "Chain archived."
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
