var ReactSimulation = React.createClass({
  propTypes: {
    predictions: React.PropTypes.array,
    access_id: React.PropTypes.number,
    sensor_values: React.PropTypes.object,
    src: React.PropTypes.string
  },

  getInitialState: function(){
    return{
      predictions: this.props.predictions,
      update: false
    }
  },

  render: function(){
    this.state.update = false;
    return (
      <div className="container text-center">
        <div className="row">
          <h3>Version Space Sets</h3>

          <hr/>
          <ReactIframe
            src={this.props.src}
            width={'100%'}
            height={'450'}
          />

          <hr/>
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
    this.setState({ predictions: this.state.predictions, update: true });
  },

  deleteRequestSuccess: function(response){
    document.sensorForm.reset();
    this.setState({ predictions: response.success, update: true });
  },

  requestError: function(response){
    alert(response.responseJSON.error);
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

