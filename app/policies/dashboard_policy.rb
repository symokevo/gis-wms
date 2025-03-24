# app/policies/dashboard_policy.rb
class DashboardPolicy < ApplicationPolicy
  def index?
    true # All roles can access dashboard
  end

  def admin?
    user.admin?
  end
end
