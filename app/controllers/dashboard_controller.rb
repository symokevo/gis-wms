# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    case current_user.role.to_sym # Convert role to symbol for comparison
    when :admin
      @users = User.all
      @pipelines = Pipeline.all
    when :field_technician
      @assigned_pipelines = current_user.assigned_pipelines
    when :non_revenue
      @leak_reports = Pipeline.leak_detected
    else
      @pipelines = Pipeline.all
    end
  end
end
