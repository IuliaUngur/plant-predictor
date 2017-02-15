var ReactSimulation = React.createClass({
  propTypes: {
    cube_path: React.PropTypes.string,
    sensor_images: React.PropTypes.array,
    predictions: React.PropTypes.array
  },

  getInitialState: function(){
    return{
      predictions: this.props.predictions
    }
  },

  sensorsTable: function(){
    var tableContent = this.state.predictions.map((prediction, index) => {
      return <tr>
               <td>{prediction[0]}</td>
               <td>{prediction[1]}</td>
               <td>{prediction[2]}</td>
               <td>{prediction[3]}</td>
               <td>{prediction[4]}</td>
               <td>{prediction[5]}</td>
               <td>{prediction[6]}</td>
             </tr>
    });

    return(
      <table className="table table-striped table-bordered margin-top-20">
        <thead>
          <tr>
            <th>Temperature</th>
            <th>Light</th>
            <th>Distance</th>
            <th>Humidity</th>
            <th>Vibrations</th>
            <th>Rain Quantity</th>
            <th>Algorithm Outcome</th>
          </tr>
        </thead>
        <tbody>
          {tableContent}
        </tbody>
      </table>
    );
  },

  sensorForm: function(){
    return(
      <div className="container-fluid text-left">
        <form name="sensorForm" onSubmit={this.submitForm}>
          <div className="form-group">
            <label>Light:</label>
            <select className="form-control" name="light">
              <option value="light-dark">DARK</option>
              <option value="light-moonlight">MOONLIGHT</option>
              <option value="light-fog">FOG</option>
              <option value="light-clear">CLEAR</option>
              <option value="light-sunny">SUNNY</option>
            </select>
          </div>

          <div className="form-group">
            <label>Temperature (C):</label>
            <input type="number" className="form-control" name="temperature"/>
          </div>

          <div className="form-group">
            <label>Vibration:</label>
            <input type="number" className="form-control" name="vibration" min="0" max="1000"/>
          </div>

          <div className="form-group">
            <label>Humidity (%):</label>
            <input type="number" className="form-control" name="humidity" min="0" max="100"/>
          </div>

          <div className="form-group">
            <label>Rain:</label>
            <select className="form-control" name="raindrop">
              <option value="raindrop-dry">DRY</option>
              <option value="raindrop-condense">CONDENSE</option>
              <option value="raindrop-drizzle">DRIZZLE</option>
              <option value="raindrop-heavy">HEAVY RAIN</option>
              <option value="raindrop-flood">FLOOD</option>
            </select>
          </div>

          <div className="form-group">
            <label>Distance (cm):</label>
            <input type="number" className="form-control" name="distance" min="0"/>
          </div>

          <input className="btn btn-default" type="submit" value="Submit"/>
        </form>
      </div>
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
    alert("created with success");
    document.sensorForm.reset();
    this.state.predictions.unshift(response.success);
    this.setState({ predictions: this.state.predictions });
  },

  createRequestError: function(response){
    console.log(response.error);
  },

  deleteRequestSuccess: function(response){
    alert("deleted with success");
    document.sensorForm.reset();
    this.setState({ predictions: [] });
  },

  deleteRequestError: function(response){
    console.log(response.error);
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
      url: '/predictions/1',
      data: { prediction_type: "simulation" },
      success: this.deleteRequestSuccess,
      error: this.deleteRequestError
    });
  }
});

