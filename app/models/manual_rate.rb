# frozen_string_literal: true

class ManualRate < ApplicationRecord
  validates :rate, presence: true
  validates :die_at, presence: true
  validate :die_at_cannot_be_in_the_past

  has_one :quote, as: :current_rate

  def die_at_cannot_be_in_the_past
    errors.add(:die_at, "Can't be in the past") if die_at < Time.current
  end
end
