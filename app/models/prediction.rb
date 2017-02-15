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
  }
end
