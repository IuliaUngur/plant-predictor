class Sensor < ActiveRecord::Base
  has_many :readings, dependent: :delete_all
  belongs_to :version_set
end
