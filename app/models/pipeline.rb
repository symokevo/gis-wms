class Pipeline < ApplicationRecord
  # app/models/pipeline.rb
  def self.to_csv
    CSV.generate do |csv|
      csv << [ "Name", "Flow Rate (L/s)", "Pressure (psi)" ]
      all.each do |pipeline|
        csv << [ pipeline.name, pipeline.flow_rate, pipeline.pressure ]
      end
    end
  end
end
