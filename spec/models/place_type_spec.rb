require 'rails_helper'

RSpec.describe PlaceType do

  let(:place_type_data) { YAML.load_file(PlaceType::DATA_PATH) }

  describe '.all' do
    it 'returns a hash with all key / values from DATA_PATH' do
      expect(PlaceType.all).to eq(place_type_data)
    end
  end

  describe '.keys' do
    it 'returns the keys from all of the type data' do
      expect(PlaceType.keys).to eq(place_type_data.keys)
    end
  end

  describe '.values' do
    it 'returns the values from all of the type data' do
      expect(PlaceType.values).to eq(place_type_data.values)
    end
  end

end
