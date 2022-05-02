class Excel::UpdateSerializer < ActiveModel::Serializer
  include ActionView::Helpers::TextHelper
  include Rails.application.routes.url_helpers

  attributes :id, :data, :fees, :created_at

  def data
    binding.pry
  end
end