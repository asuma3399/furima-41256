class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchase_records
  has_many :comments

  with_options presence: true do
    validates :nickname
    VALID_NAME_REGEX = /\A[ぁ-んァ-ヶー一-龠々]+\z/
    validates :last_name, format: { with: VALID_NAME_REGEX }
    VALID_NAME_REGEX = /\A[ぁ-んァ-ヶー一-龠々]+\z/
    validates :first_name, format: { with: VALID_NAME_REGEX }
    VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/
    validates :last_name_ruby, format: { with: VALID_KANA_REGEX }
    VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/
    validates :first_name_ruby, format: { with: VALID_KANA_REGEX }
    validates :birth_date
  end

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX }
end

