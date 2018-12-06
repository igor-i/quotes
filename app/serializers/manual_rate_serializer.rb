# frozen_string_literal: true

class ManualRateSerializer < ActiveModel::Serializer
  attributes :id, :rate, :updated_at
end
