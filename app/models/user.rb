class User < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Define the roles using enum
  enum :role, {
    admin: 0,
    engineer: 1,
    field_technician: 2,
    non_revenue: 3,
    utility_manager: 4
  }, prefix: true

  # Set a default role
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :field_technician # Default role
  end
end
