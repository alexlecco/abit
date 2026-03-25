class HabitPolicy < ApplicationPolicy
  def create? = true
  def new? = true
  def show? = record.user == user
  def update? = record.user == user
  def edit? = update?
  def destroy? = record.user == user
end
