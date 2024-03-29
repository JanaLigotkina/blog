class User < ApplicationRecord
  has_secure_password

  before_save :downcase_nickname

  validates :nickname, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def downcase_nickname
    nickname.downcase!
  end
end
