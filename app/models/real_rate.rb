# frozen_string_literal: true

# :nodoc:
class RealRate < ApplicationRecord
  validates :rate, presence: true

  has_one :quote, as: :current_rate
end
