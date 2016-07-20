class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :first_name, presence: true, length: { within: 3..60 }
  validates :last_name, presence: true, length: { within: 2..60 }
  # Validates email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { within: 3..255}
  validates :email, format: { with: VALID_EMAIL_REGEX}

  # Validating phone numbers
  VALID_TELEPHONE_REGEX = /\A(\+\d\d|00\d\d)?\d{9}\z/
  validates :phone, presence: true, length: { within: 9..13}
  validates :phone, format: { with: VALID_TELEPHONE_REGEX}

  has_many :offsprings, dependent: :destroy
end
