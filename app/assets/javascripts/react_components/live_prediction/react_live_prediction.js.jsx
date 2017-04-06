var ReactLivePrediction = React.createClass({
  propTypes: {
    src_readings: React.PropTypes.string,
    src_hypotheses: React.PropTypes.string,

    predictions: React.PropTypes.array,
    access_id: React.PropTypes.number,
    sensor_values: React.PropTypes.object,
    available_plants: React.PropTypes.array,
    reload_time: React.PropTypes.number
  },

  getInitialState: function(){
    var that = this;
    setInterval(function(){
      that.reloadPredictions();
    }, this.props.reload_time);

    return{
      predictions: this.props.predictions,
      src_readings: this.props.src_readings,
      src_hypotheses: this.props.src_hypotheses,
      selection: ''
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

          <ReactDataLoad
            available_plants={this.props.available_plants}
            selected_predictions={this.selectedPredictions}
          />

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
          <ReactPredictionTable
            predictions={this.state.predictions}
            plant={this.state.selection}
          />
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

  reloadRequestSuccess: function(response){
    this.state.predictions.unshift(response.predictions);
    this.setState({
      predictions: this.state.predictions,
      src_readings: response.src.readings,
      src_hypotheses: response.src.live
    });
  },

  loadRequestSuccess: function(response){
    this.setState({ predictions: response.predictions });
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
        prediction_type: 'live',
        plant_selection: this.state.selection
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
  },

  selectedPredictions: function(selection){
    this.state.selection = selection;
    $.ajax({
      type: 'GET',
      url: '/predictions/' + this.props.access_id + '/load_data',
      data: {
        prediction_type: 'live',
        plant_selection: selection
      },
      success: this.loadRequestSuccess,
      error: this.requestError
    });
  },

  reloadPredictions: function(){
    $.ajax({
      type: 'GET',
      url: '/predictions/reload_predictions',
      data: { plant_selection: this.state.selection },
      success: this.reloadRequestSuccess,
      error: function(){}
    });
  }
});
