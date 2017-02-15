var ReactSimulation = React.createClass({
  propTypes: {
    cube_path: React.PropTypes.string,
    sensor_images: React.PropTypes.object,
    predictions: React.PropTypes.array,
    access_id: React.PropTypes.number,
    sensor_values: React.PropTypes.object
  },

  getInitialState: function(){
    return{
      predictions: this.props.predictions
    }
  },

  sensorOptions: function(sensor){
    return (
      <select className="form-control" name={sensor}>
        {
          this.props.sensor_values[sensor].map((value, index) => {
            return <option key={index} value={value}>{value}</option>
          })
        }
      </select>
    );
  },

  sensorForm: function(){
    return(
      <div className="container-fluid text-left">
        <form name="sensorForm" onSubmit={this.submitForm}>
          <div className="form-group">
            <label>Light:</label>
            {this.sensorOptions("light")}
          </div>

          <div className="form-group">
            <label>Temperature (C):</label>
            <input type="number" className="form-control" name="temperature" required="true"/>
          </div>

          <div className="form-group">
            <label>Vibration:</label>
            <input type="number" className="form-control" name="vibration" min="0" max="1000" required="true"/>
          </div>

          <div className="form-group">
            <label>Humidity (%):</label>
            <input type="number" className="form-control" name="humidity" min="0" max="100"
            required="true"/>
          </div>

          <div className="form-group">
            <label>Rain:</label>
            {this.sensorOptions("raindrop")}
          </div>

          <div className="form-group">
            <label>Distance (cm):</label>
            <input type="number" className="form-control" name="distance" min="0" required="true"/>
          </div>

          <input className="btn btn-default" type="submit" value="Submit"/>
        </form>
      </div>
    );
  },

  sensorsTable: function(){
    var tableContent = this.state.predictions.map((prediction, index) => {
      return <tr key={index}>
               <td>{prediction.light}</td>
               <td>{prediction.temperature}</td>
               <td>{prediction.distance}</td>
               <td>{prediction.raindrop}</td>
               <td>{prediction.humidity}</td>
               <td>{prediction.vibration}</td>
               <td>{prediction.result}</td>
             </tr>
    });

    return(
      <table className="table table-striped table-bordered margin-top-20">
        <thead>
          <tr>
            <th>Light</th>
            <th>Temperature</th>
            <th>Distance</th>
            <th>Rain Quantity</th>
            <th>Humidity</th>
            <th>Vibrations</th>
            <th>Algorithm Outcome</th>
          </tr>
        </thead>
        <tbody>
          {tableContent}
        </tbody>
      </table>
    );
  },

  render: function(){
    return (
      <div className="container text-center">
        <div className="row">
          <div className="col-sm-8">
            <h3>Simulation Prototype</h3>
            <img src={this.props.cube_path} className="img-responsive"/>
          </div>
          <div className="col-sm-4">
            <h3>Sensor Inputs</h3>
            {this.sensorForm()}
          </div>
        </div>
        <hr/>
        <h3>Readings</h3>
        {this.sensorsTable()}
        <button type="button" className="btn btn-default" onClick={this.resetPredictions}>Clear Simulation</button>
      </div>
    );
  },

// AJAX Responses

  createRequestSuccess: function(response){
    document.sensorForm.reset();
    this.state.predictions.unshift(response.success);
    this.setState({ predictions: this.state.predictions });
  },

  createRequestError: function(response){
    alert(response.error);
    document.sensorForm.reset();
    this.setState({ predictions: this.state.predictions });
  },

  deleteRequestSuccess: function(response){
    document.sensorForm.reset();
    this.setState({ predictions: response.success });
  },

  deleteRequestError: function(response){
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
        distance: fields.distance.value
      },
      success: this.createRequestSuccess,
      error: this.createRequestError
    });
  },

  resetPredictions: function(event){
    event.preventDefault();
    $.ajax({
      type: 'DELETE',
      url: '/predictions/' + this.props.access_id,
      data: { prediction_type: 'simulation' },
      success: this.deleteRequestSuccess,
      error: this.deleteRequestError
    });
  }
});

