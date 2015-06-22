class PlaceType

  DATA_PATH = 'config/data/place_types.yml'

  @@all = YAML.load_file(DATA_PATH).freeze

  cattr_reader :all

  class << self

    def keys
      all.keys
    end

    def values
      all.values
    end

  end

end
