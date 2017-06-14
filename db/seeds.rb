Prediction.where(environment: "data").destroy_all
Prediction.create(environment: "simulation")
Prediction.create(environment: "live")

szeged = Prediction.create(environment: "data", result: "szeged survives")
soybean = Prediction.create(environment: "data", result: "soybean survives")
rice = Prediction.create(environment: "data", result: "rice survives")
cotton = Prediction.create(environment: "data", result: "cotton survives")
corn = Prediction.create(environment: "data", result: "corn survives")


Sensor.create(name: "light", measurement: "limited", value: "CLEAR", prediction: szeged)
Sensor.create(name: "temperature", measurement: "limited", value: "COOL", prediction: szeged)
Sensor.create(name: "vibration", measurement: "continuous", value: "11", prediction: szeged)
Sensor.create(name: "humidity", measurement: "continuous", value: "82", prediction: szeged)
Sensor.create(name: "raindrop", measurement: "limited", value: "DRIZZLE", prediction: szeged)
Sensor.create(name: "distance", measurement: "limited", value: "NEARBY", prediction: szeged)

Sensor.create(name: "light", measurement: "limited", value: "CLEAR", prediction: soybean)
Sensor.create(name: "temperature", measurement: "limited", value: "COOL", prediction: soybean)
Sensor.create(name: "vibration", measurement: "continuous", value: "11", prediction: soybean)
Sensor.create(name: "humidity", measurement: "continuous", value: "82", prediction: soybean)
Sensor.create(name: "raindrop", measurement: "limited", value: "DRIZZLE", prediction: soybean)
Sensor.create(name: "distance", measurement: "limited", value: "NEARBY", prediction: soybean)

Sensor.create(name: "light", measurement: "limited", value: "CLEAR", prediction: rice)
Sensor.create(name: "temperature", measurement: "limited", value: "COOL", prediction: rice)
Sensor.create(name: "vibration", measurement: "continuous", value: "11", prediction: rice)
Sensor.create(name: "humidity", measurement: "continuous", value: "82", prediction: rice)
Sensor.create(name: "raindrop", measurement: "limited", value: "DRIZZLE", prediction: rice)
Sensor.create(name: "distance", measurement: "limited", value: "NEARBY", prediction: rice)

Sensor.create(name: "light", measurement: "limited", value: "CLEAR", prediction: cotton)
Sensor.create(name: "temperature", measurement: "limited", value: "COOL", prediction: cotton)
Sensor.create(name: "vibration", measurement: "continuous", value: "11", prediction: cotton)
Sensor.create(name: "humidity", measurement: "continuous", value: "82", prediction: cotton)
Sensor.create(name: "raindrop", measurement: "limited", value: "DRIZZLE", prediction: cotton)
Sensor.create(name: "distance", measurement: "limited", value: "NEARBY", prediction: cotton)

Sensor.create(name: "light", measurement: "limited", value: "CLEAR", prediction: corn)
Sensor.create(name: "temperature", measurement: "limited", value: "COOL", prediction: corn)
Sensor.create(name: "vibration", measurement: "continuous", value: "11", prediction: corn)
Sensor.create(name: "humidity", measurement: "continuous", value: "82", prediction: corn)
Sensor.create(name: "raindrop", measurement: "limited", value: "DRIZZLE", prediction: corn)
Sensor.create(name: "distance", measurement: "limited", value: "NEARBY", prediction: corn)

system("rake ENVIRONMENT=simulation PLANT=szeged import_csv")
system("rake ENVIRONMENT=live PLANT=szeged import_csv")
