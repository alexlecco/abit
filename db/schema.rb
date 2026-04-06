# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_04_06_023552) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "activities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "habit_id", null: false
    t.integer "position", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_activities_on_habit_id"
  end

  create_table "activity_completions", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.date "completed_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["activity_id", "completed_on"], name: "index_activity_completions_on_activity_id_and_completed_on", unique: true
    t.index ["activity_id", "user_id", "completed_on"], name: "idx_on_activity_id_user_id_completed_on_6b83b1b1a3"
    t.index ["activity_id"], name: "index_activity_completions_on_activity_id"
    t.index ["user_id"], name: "index_activity_completions_on_user_id"
  end

  create_table "daily_checkins", force: :cascade do |t|
    t.date "checked_on", null: false
    t.datetime "created_at", null: false
    t.bigint "habit_id", null: false
    t.text "notes"
    t.integer "progress_score", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["habit_id", "checked_on"], name: "index_daily_checkins_on_habit_id_and_checked_on", unique: true
    t.index ["habit_id", "user_id", "checked_on"], name: "index_daily_checkins_on_habit_id_and_user_id_and_checked_on"
    t.index ["habit_id"], name: "index_daily_checkins_on_habit_id"
    t.index ["user_id"], name: "index_daily_checkins_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.bigint "habit_id", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_goals_on_habit_id", unique: true
  end

  create_table "habit_logs", force: :cascade do |t|
    t.date "completed_on"
    t.datetime "created_at", null: false
    t.bigint "habit_id", null: false
    t.text "notes"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["habit_id", "completed_on"], name: "index_habit_logs_on_habit_id_and_completed_on", unique: true
    t.index ["habit_id"], name: "index_habit_logs_on_habit_id"
    t.index ["user_id", "completed_on"], name: "index_habit_logs_on_user_id_and_completed_on"
    t.index ["user_id"], name: "index_habit_logs_on_user_id"
  end

  create_table "habits", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.string "color", default: "#14B8A6"
    t.datetime "created_at", null: false
    t.integer "current_streak", default: 0, null: false
    t.text "description"
    t.integer "longest_streak", default: 0, null: false
    t.string "name", null: false
    t.string "path_type"
    t.integer "position", default: 0
    t.date "start_date"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_habits_on_user_id"
  end

  create_table "learning_resources", force: :cascade do |t|
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.bigint "habit_id", null: false
    t.text "notes"
    t.integer "position", default: 0, null: false
    t.string "resource_type", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.integer "week_number", null: false
    t.index ["habit_id", "week_number"], name: "index_learning_resources_on_habit_id_and_week_number"
    t.index ["habit_id"], name: "index_learning_resources_on_habit_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "provider"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "timezone"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weekly_milestones", force: :cascade do |t|
    t.text "acceptance_criteria"
    t.boolean "achieved", default: false, null: false
    t.datetime "achieved_at"
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.bigint "goal_id", null: false
    t.text "reflection"
    t.datetime "updated_at", null: false
    t.integer "week_number", null: false
    t.index ["goal_id", "week_number"], name: "index_weekly_milestones_on_goal_id_and_week_number", unique: true
    t.index ["goal_id"], name: "index_weekly_milestones_on_goal_id"
  end

  add_foreign_key "activities", "habits"
  add_foreign_key "activity_completions", "activities"
  add_foreign_key "activity_completions", "users"
  add_foreign_key "daily_checkins", "habits"
  add_foreign_key "daily_checkins", "users"
  add_foreign_key "goals", "habits"
  add_foreign_key "habit_logs", "habits"
  add_foreign_key "habit_logs", "users"
  add_foreign_key "habits", "users"
  add_foreign_key "learning_resources", "habits"
  add_foreign_key "weekly_milestones", "goals"
end
