var ReactSimulation = React.createClass({
  propTypes: {
    background_path: React.PropTypes.string,
    components_images: React.PropTypes.object,
    components_informations: React.PropTypes.object,

    predictions: React.PropTypes.array,
    access_id: React.PropTypes.number,
    sensor_values: React.PropTypes.object
  },

  getInitialState: function(){
    return{
      predictions: this.props.predictions
    }
  },

  render: function(){
    return (
      <div className="container text-center">
        <div className="row">
          <h3>Sensor Inputs</h3>
          <br/>
          <ReactSensorInputs
            predictions={this.state.predictions}
            sensor_values={this.props.sensor_values}
            submit_function={this.submitForm}
          />

          <hr/>
          <h3>Readings</h3>
          <ReactPredictionTable predictions={this.state.predictions} />
          <button type="button" className="btn btn-default" onClick={this.resetPredictions}>Clear Simulation</button>
        </div>
      </div>
    );
  },

// AJAX Responses

  createRequestSuccess: function(response){
    document.sensorForm.reset();
    this.state.predictions.unshift(response.success);
    this.setState({ predictions: this.state.predictions });
  },

  deleteRequestSuccess: function(response){
    document.sensorForm.reset();
    this.setState({ predictions: response.success });
  },

  requestError: function(response){
    alert(response.error);
    document.sensorForm.reset();
    this.setState({ predictions: this.state.predictions });
  },

// AJAX Requests

  submitForm: function(event){
    event.preventDefault();
    var fields = document.sensorForm.getElementsByClassName('form-control');
    $.ajax({
      type: 'POST',
      url: '/predictions',
      data: {
        light: fields.light.value,
        temperature: fields.temperature.value,
        vibration: fields.vibration.value,
        humidity: fields.humidity.value,
        raindrop: fields.raindrop.value,
        distance: fields.distance.value,
        prediction_type: 'simulation'
      },
      success: this.createRequestSuccess,
      error: this.requestError
    });
  },

  resetPredictions: function(event){
    event.preventDefault();
    $.ajax({
      type: 'DELETE',
      url: '/predictions/' + this.props.access_id,
      data: { prediction_type: 'simulation' },
      success: this.deleteRequestSuccess,
      error: this.requestError
    });
  }
});

