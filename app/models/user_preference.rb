class UserPreference < ActiveRecord::Base

  MIN_RATING_VALUE = 0
  MAX_RATING_VALUE = 4.5
  RATING_STEP = 0.5

  store_accessor :types

  # Associations

  belongs_to :user

  # Callbacks

  before_validation :whitelist_types!

  # Validations

  validates :min_rating, { presence: true }
  validates :types, { presence: true }

  validate :min_rating_within_range_and_step

  def self.rating_values
    (MIN_RATING_VALUE..MAX_RATING_VALUE).step(RATING_STEP).to_a
  end

  private

  def min_rating_within_range_and_step
    unless self.class.rating_values.include?(min_rating)
      errors.add(:min_rating, :inclusion,
                 min: MIN_RATING_VALUE,
                 max: MAX_RATING_VALUE,
                 step: RATING_STEP)
    end
  end

  def whitelist_types!
    types.keep_if { |t| PlaceType.keys.include?(t) } if types
  end

end
