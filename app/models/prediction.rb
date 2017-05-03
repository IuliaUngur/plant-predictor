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

  scope :predictions_on_plants, -> (environment, plant) {
    predictions_with_sensors(environment)
      .where("result LIKE ?", "#{plant}%")
      .distinct
  }

  def sensor_result_set
    p = Hash[sensors.collect { |s| [ s.name.to_sym, s.value ] } ]
    p.merge!(result: result.to_s, id: id)
  end

  def sensor_set
    Hash[sensors.collect { |s| [ s.name.to_sym, s.value ] } ]
  end
end
