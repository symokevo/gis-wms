class CreatePipelines < ActiveRecord::Migration[8.0]
  def change
    create_table :pipelines do |t|
      t.string :name
      t.float :flow_rate
      t.float :pressure
      t.st_point :coordinates, geographic: true

      t.timestamps
    end
  end
end
