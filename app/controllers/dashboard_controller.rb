# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    case current_user.role
    when "admin"
      @users = User.all
      @pipelines = Pipeline.all
    when "field_technician"
      @assigned_pipelines = current_user.assigned_pipelines
    when "non_revenue"
      @leak_reports = Pipeline.leak_detected
    end
  end
end
