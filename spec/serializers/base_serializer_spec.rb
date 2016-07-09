require 'rails_helper'

RSpec.describe BaseSerializer do

  let(:object) { User.new }

  subject(:base_json) { JSON.parse(serialize_object(object))['data']['attributes'] }

  it 'serializes errors as a hash when present' do
    object.valid?
    base_json['errors'].keys.each do |field|
      expect(base_json['errors'][field]).to eq(object.errors[field.underscore])
    end
  end

  it 'serializes errors as nil when not present' do
    object = User.new
    expect(base_json['errors']).to be_nil
  end

end
