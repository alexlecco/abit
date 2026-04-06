class LearningResource < ApplicationRecord
  RESOURCE_TYPES = %w[course guide workshop video article].freeze

  belongs_to :habit

  validates :title, presence: true
  validates :resource_type, inclusion: { in: RESOURCE_TYPES }
  validates :week_number, inclusion: { in: 1..4 }
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(:week_number, :position, :created_at) }
  scope :for_week, ->(n) { where(week_number: n) }

  def completed?
    completed_at.present?
  end
end
