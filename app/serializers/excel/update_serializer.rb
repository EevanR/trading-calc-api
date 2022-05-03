class Excel::UpdateSerializer < ActiveModel::Serializer
  include ActionView::Helpers::TextHelper
  include Rails.application.routes.url_helpers

  attributes :id, :data, :fees, :created_at

  def data
    if instance_options[:scope].role == 'subscriber'
      object.data
    else
      object.data.length > 10 ? object.data = object.data.slice(object.data.length-10,object.data.length) : object.data
    end
  end
end