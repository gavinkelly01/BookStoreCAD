class User < ApplicationRecord
   ROLES = %w[user admin].freeze
  validates :role, presence: true, inclusion: { in: ROLES }

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end
end
