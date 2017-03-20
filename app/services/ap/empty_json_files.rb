module Ap
  class EmptyJsonFiles
    def initialize(environment)
      @environment = environment
    end

    def perform
      delete_hypotheses(@environment)
      return if @environment == 'simulation'

      delete_readings
    end

    def delete_readings
      readings = {
        light: "",
        temperature: "",
        distance: "",
        raindrop: "",
        humidity: "",
        vibration: ""
      }
      write_to_file('sensor_readings', readings)
    end

    def delete_hypotheses(environment)
      version_space = {
        general: '',
        specific: ''
      }
      write_to_file("#{environment}_hypotheses", version_space)
    end

    def write_to_file(file, data)
      File.open("public/#{file}.json", 'w') do |f|
        f.puts JSON.pretty_generate(data)
      end
    end
  end
end
