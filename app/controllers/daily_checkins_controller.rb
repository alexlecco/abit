class DailyCheckinsController < ApplicationController
  before_action :require_login
  before_action :set_habit

  def create
    @checkin = @habit.daily_checkins.find_or_initialize_by(
      checked_on: Date.current,
      user: current_user
    )
    @checkin.assign_attributes(checkin_params)

    respond_to do |format|
      if @checkin.save
        @today_checkin = @checkin
        @current_milestone = @habit.goal&.milestone_for_week(@habit.current_week_number)
        format.turbo_stream
        format.html { redirect_to habit_path(@habit) }
      else
        format.html { redirect_to habit_path(@habit), alert: @checkin.errors.full_messages.to_sentence }
      end
    end
  end

  def destroy
    @checkin = @habit.daily_checkins.find_by(checked_on: Date.current, user: current_user)
    @checkin&.destroy
    @today_checkin = nil
    @current_milestone = @habit.goal&.milestone_for_week(@habit.current_week_number)
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

  def checkin_params
    params.require(:daily_checkin).permit(:progress_score, :notes)
  end
end
