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
            <input type="text" className="form-control" name="light"/>
          </div>

          <div className="form-group">
            <label>Temperature:</label>
            <input type="text" className="form-control" name="temperature"/>
          </div>

          <div className="form-group">
            <label>Vibration:</label>
            <input type="text" className="form-control" name="vibration"/>
          </div>

          <div className="form-group">
            <label>Humidity:</label>
            <input type="text" className="form-control" name="humidity"/>
          </div>

          <div className="form-group">
            <label>Raindrops:</label>
            <input type="text" className="form-control" name="raindrop"/>
          </div>

          <div className="form-group">
            <label>Distance:</label>
            <input type="text" className="form-control" name="distance"/>
          </div>

          <input className="btn btn-default" type="submit" value="Submit"/>
        </form>
      </div>
    );
  },

  simulation: function(){
    return(
      <div>
        <h3>Readings</h3>
        {this.sensorForm()}
        {this.sensorsTable()}
      </div>
    );
  },

  hardwareCube: function(){
    return(
      <div>
        <h1>Simulation</h1>
        <img src={this.props.cube_path} className="img-responsive"/>
        <hr/>
      </div>
    );
  },

  render: function(){
    return (
      <div className="container text-center ">
        {/*{this.hardwareCube()}*/}
        {this.simulation()}
        <button type="button" className="btn btn-default" onClick={this.resetPredictions}>Clear Simulation</button>
      </div>
    );
  },

// AJAX

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

  submitForm: function(event){
    event.preventDefault();
    var inputs = document.getElementsByTagName('input');
    $.ajax({
      type: 'POST',
      url: '/predictions',
      data: {
        light: inputs.light.value,
        temperature: inputs.temperature.value,
        vibration: inputs.vibration.value,
        humidity: inputs.humidity.value,
        raindrop: inputs.raindrop.value,
        distance: inputs.distance.value
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
      success: this.deleteRequestSuccess,
      error: this.deleteRequestError
    });
  }
});

