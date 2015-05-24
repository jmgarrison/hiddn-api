class AuthToken < ActiveRecord::Base

  DEFAULT_DURATION = 6.months

  before_validation :set_expires_at, on: :create
  before_validation :generate_value!

  # Associations

  belongs_to :user

  # Validations

  validates :expires_at, { presence: true }
  validates :user, { presence: true }
  validates :value, { presence: true }

  validate :expires_at_before_now, on: :create

  # Scopes

  scope :active, -> { where('expires_at >= ?', Time.zone.now) }
  scope :expired, -> { where('expires_at < ?', Time.zone.now) }

  private

  def expires_at_before_now
    if self.expires_at < Time.zone.now
      errors.add(:expires_at, :in_past, now: Time.zone.now)
    end
  end

  def generate_value!
    self.value = SecureRandom.base64 unless self.value
  end

  def set_expires_at
    self.expires_at = Time.zone.now + DEFAULT_DURATION unless self.expires_at
  end

end
