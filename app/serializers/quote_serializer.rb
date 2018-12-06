class QuoteSerializer < ActiveModel::Serializer
  attributes :id, :currency_pair, :current_rate, :state

  def current_rate
   return "#{object.current_rate_type}Serializer".constantize.new(object.current_rate, scope: scope) if object.current_rate
   { rate: nil, updated_at: nil }
  end
end
