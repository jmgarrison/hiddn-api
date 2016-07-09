module Serialization

  def serialize_object(object)
    ActiveModelSerializers::SerializableResource.new(object).to_json
  end

end

RSpec.configure do |config|
  config.include Serialization
end
