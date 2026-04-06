class Activity < ApplicationRecord
  belongs_to :habit
  has_many :activity_completions, dependent: :destroy

  validates :title, presence: true
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(:position, :created_at) }
end
