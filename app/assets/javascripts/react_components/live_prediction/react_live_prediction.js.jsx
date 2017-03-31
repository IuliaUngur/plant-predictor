var ReactLivePrediction = React.createClass({
  propTypes: {
    src_readings: React.PropTypes.string,
    src_hypotheses: React.PropTypes.string,

    predictions: React.PropTypes.array,
    access_id: React.PropTypes.number,
    sensor_values: React.PropTypes.object,
  },

  getInitialState: function(){
    return{
      predictions: this.props.predictions,
      src_readings: this.props.src_readings,
      src_hypotheses: this.props.src_hypotheses
    }
  },

  render: function(){
    return (
      <div className="container text-center">
        <div className="row">
          <h3>Plant Value Readings</h3>
          <hr/>
          <br/>
          <div className="row">
            <div className="col-lg-6">
              <h3>Sensor Readings</h3>
              <ReactJson
                src={this.state.src_readings}
                height={450}
              />
            </div>
            <div className="col-lg-6">
              <h3>Version Space Sets</h3>
              <ReactJson
                src={this.state.src_hypotheses}
                height={450}
              />
            </div>
          </div>

          <hr/><br/>

          <div className="col-lg-8">
            <strong className="pull-left" style={{paddingTop: '5px'}}>Select plant for prediction:</strong>
            <div className="form-group col-lg-6">
              <select className="form-control" name="plant-selector">
                <option value="basil">basil</option>
                <option value="tomato">tomato</option>
                <option value="banana">banana</option>
                <option value="potato">potato</option>
                <option value="beans">beans</option>
                <option value="rice">rice</option>
                <option value="wheat">wheat</option>
                <option value="corn">corn</option>
                <option value="aloe">aloe</option>
              </select>
            </div>
            <button type="button" className="btn btn-default pull-left">Load Training Data</button>
          </div>

          <button type="button" className="btn btn-default pull-right" onClick={this.resetPredictions}>
            Clear Simulation
          </button>

          <br/><br/><hr/>
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
        </div>
      </div>
    );
  },

// AJAX Responses

  createRequestSuccess: function(response){
    document.sensorForm.reset();
    this.state.predictions.unshift(response.predictions);
    this.setState({
      predictions: this.state.predictions,
      src_readings: response.src.readings,
      src_hypotheses: response.src.live
    });
  },

  deleteRequestSuccess: function(response){
    document.sensorForm.reset();
    this.setState({
      predictions: response.predictions,
      src_readings: response.src.readings,
      src_hypotheses: response.src.live
    });
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
        prediction_type: 'live'
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
      data: { prediction_type: 'live' },
      success: this.deleteRequestSuccess,
      error: this.requestError
    });
  }
});
