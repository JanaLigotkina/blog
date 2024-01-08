class User < ApplicationRecord
  has_secure_password

  before_save :downcase_nickname

  validates :nickname, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }

  def downcase_nickname
    nickname.downcase!
  end
end
