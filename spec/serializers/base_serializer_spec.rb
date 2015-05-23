require 'rails_helper'

RSpec.describe BaseSerializer do

  it 'serializes errors as a hash when present' do
    object = User.new
    object.valid?
    serializer = BaseSerializer.new(object)
    json = JSON.parse(serializer.to_json)
    expect(json['base']['errors']).to eq(object.errors.to_hash.with_indifferent_access)
  end

  it 'serializer errors as nil when not present' do
    object = User.new
    serializer = BaseSerializer.new(object)
    json = JSON.parse(serializer.to_json)
    expect(json['base']['errors']).to be_nil
  end

end
