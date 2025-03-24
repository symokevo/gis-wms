class ReportsController < ApplicationController
  def water_usage
  end

  def water_usage
    @pipelines = Pipeline.all
    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text "Water Usage Report", size: 24
        @pipelines.each do |pipeline|
          pdf.text "#{pipeline.name}: #{pipeline.flow_rate} L/s"
        end
        send_data pdf.render, filename: "water_usage.pdf"
      end
      format.csv { send_data @pipelines.to_csv }
    end
  end
end
