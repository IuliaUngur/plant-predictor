class Prediction < ActiveRecord::Base
  has_many :sensors, dependent: :destroy

  scope :predictions_without_sensors, -> (environment) {
    left_outer_joins(:sensors)
      .where(sensors: { id: nil })
      .where(environment: environment)
  }

  scope :predictions_with_sensors, -> (environment) {
    joins(:sensors)
      .where(environment: environment)
      .order(created_at: :desc)
  }

  def sensor_result_set
    p = {}
    sensors.map do |sensor|
      p.merge!(sensor.name => sensor.value)
    end
    p.merge!(result: result.to_s)
  end
end
