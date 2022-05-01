class Excels::IndexSerializer < ActiveModel::Serializer
  include ActionView::Helpers::TextHelper
  include Rails.application.routes.url_helpers

  attributes :id, :data, :fees, :created_at

  def trades
    binding.pry
    if instance_options[:role] == 'subscriber'
      object.trades
    else
      # truncate(object.body, length: 75)
    end
  end
end