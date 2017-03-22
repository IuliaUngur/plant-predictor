# README

Version Space Generalization using Plant Growth Predictions on noisy and uncertain data
---------------------
To see live:
* [plant-predictor](https://plant-predictor.herokuapp.com/)


Installation:

* For ruby/git/rails installation please see this tutorial: [RailsGirls](http://guides.railsgirls.com/install)
  - Note: PostgreSQL database is needed

  - Git:
    * `mkdir Plant`
    * `cd Plant`
    * `git init`
    * `git clone https://github.com/IuliaUngur/plant-predictor.git`
    * `cd plant-predictor`

  - Project:
    * `bundle install`
    * `rake db:create`
    * `rake db:migrate`
    * `rake db:seed`

  - For hardware setup:
    * install Arduino IDE from: [Arduino](https://www.arduino.cc/en/Main/Software)
    * install Processing from: [Processing](https://processing.org/download/?processing)

  - To run the project:
    * open Arduino IDE, load code from `vendor/arduino-plant/plant/plant.ino`
    * include library `IRremote` from `vendor/arduino-plant/IRremote.zip` (Sketch -> Include Library -> Add .Zip Library)
    * set from Tools -> Board to Arduino UNO and Port to the port it is connected to
    * upload the Sketch
    * open Processing IDE, load code from `vendor/processing-arduino/write_to_file/write_to_file.pde`
    * run project, and press OK on the remote for the project to start running
    * NOTE: encoding used on this project for the remote might not correspond to other models, if so, just edit the .ino file on the `0xFF02FD` code



To start server:
* `rails s`

To run tests:
* `rspec .`
