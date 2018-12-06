# frozen_string_literal: true

class Quote < ApplicationRecord
  extend Enumerize

  CURRENCY_PAIR = %i[usd_rub].freeze

  enumerize :currency_pair, in: CURRENCY_PAIR

  validates :currency_pair, presence: true

  belongs_to :current_rate, optional: true, polymorphic: true
  belongs_to :manual_rate, optional: true

  state_machine initial: :initial do
    state :initial
    state :updating
    state :updated do
      validates :current_rate, presence: true
    end
    state :manual do
      validates :current_rate, presence: true
      validates :manual_rate, presence: true
    end
    state :archived

    event :start_update do
      transition all => :updating
    end

    event :finish_update do
      transition updating: :updated
    end

    event :mark_as_manual do
      transition all => :manual
    end

    event :archive do
      transition all => :archived
    end
  end

  def can_update?
    !manual? || (manual_rate.die_at < Time.current)
  end
end
