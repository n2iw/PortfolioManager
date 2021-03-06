class AdminUser < ActiveRecord::Base
  has_secure_password

  # sexy validations
  validates :username, uniqueness: true,
                       presence: true
  validates :password, presence: true

  scope :sorted, lambda { order("admin_users.username") }
end
