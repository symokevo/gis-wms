class LeakDetectionJob < ApplicationJob
  queue_as :default

  def perform
    # Simulate leak detection logic
    Pipeline.where("pressure < ? OR flow_rate < ?", 20, 50).each do |pipeline|
      next unless leak_detected?(pipeline)

      # Broadcast alert via Action Cable
      ActionCable.server.broadcast(
        "pressure_alerts_#{pipeline.id}",
        { message: "Leak detected in #{pipeline.name}", location: pipeline.coordinates }
      )
    end
  end

  private

  def leak_detected?(pipeline)
    # Add custom logic (e.g., sudden pressure drop)
    pipeline.pressure < 20
  end
end
