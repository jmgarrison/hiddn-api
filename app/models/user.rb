class User < ActiveRecord::Base

  MINIMUM_PASSWORD_LENGTH = 6

  has_secure_password

  # Associations

  has_many :auth_tokens

  # Validations

  validates :email, { email: true, presence: true }
  validates :first_name, { presence: true }
  validates :last_name, { presence: true }
  validates :password, { length: { minimum: MINIMUM_PASSWORD_LENGTH } }

end
