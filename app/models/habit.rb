class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_logs, dependent: :destroy

  validates :name, presence: true
  validates :color, presence: true

  COLORS = %w[
    #14B8A6 #22C55E #EAB308 #A855F7
    #F97316 #EC4899 #3B82F6 #EF4444
  ].freeze

  scope :active, -> { where(active: true) }
  scope :ordered, -> { order(:position, :created_at) }

  def completed_on?(date)
    habit_logs.exists?(completed_on: date)
  end

  def calculate_current_streak
    streak = 0
    date = Date.current
    loop do
      break unless habit_logs.exists?(completed_on: date)
      streak += 1
      date -= 1.day
    end
    streak
  end

  def calculate_longest_streak
    logs = habit_logs.order(:completed_on).pluck(:completed_on)
    return 0 if logs.empty?

    longest = 0
    current = 1

    logs.each_cons(2) do |prev, curr|
      if (curr - prev).to_i == 1
        current += 1
        longest = current if current > longest
      else
        current = 1
      end
    end

    [ longest, current ].max
  end

  def update_streaks!
    update_columns(
      current_streak: calculate_current_streak,
      longest_streak: calculate_longest_streak
    )
  end
end
