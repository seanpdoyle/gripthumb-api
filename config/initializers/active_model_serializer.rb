ActiveModel::Serializer.class_eval do
  delegate :cache_key, to: :object
end
