# frozen_string_literal: true

# :nodoc:
class ManualRateSerializer < ActiveModel::Serializer
  attributes :id, :rate, :updated_at
end
