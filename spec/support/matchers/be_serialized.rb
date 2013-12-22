RSpec::Matchers.define :be_serialized do |record|
  def serializer_for(record)
    record.respond_to?(:each) ? ActiveModel::ArraySerializer.new(record, root: record.first.class.model_name.plural) :
                                "#{record.class.name}Serializer".constantize.new(record)
  end

  match do |response|
    expect(response).to eq serializer_for(record).to_json
  end
end