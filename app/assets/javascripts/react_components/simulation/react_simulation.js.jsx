var ReactSimulation = React.createClass({
  propTypes: {
    cube_path: React.PropTypes.string,
    sensor_images: React.PropTypes.array,
    predictions: React.PropTypes.array
  },

  getInitialState: function(){
    return{
      light: "",
      temperature: "",
      vibration: "",
      humidity: "",
      raindrop: "",
      distance: ""
    }
  },

  sensorsTable: function(){
    var tableContent = this.props.predictions.map((prediction, index) => {
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
      <table className="table table-striped table-bordered">
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
      <form onSubmit={this.submitForm}>
        Light:<input type="text" name="light"/><br/>
        Temperature:<input type="text" name="temperature"/><br/>
        Vibration:<input type="text" name="vibration"/><br/>
        Humidity:<input type="text" name="humidity"/><br/>
        Raindrops:<input type="text" name="raindrop"/><br/>
        Distance:<input type="text" name="distance"/><br/>

        <input type="submit" value="Submit"/>
      </form>
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
        {this.hardwareCube()}
        {this.simulation()}
      </div>
    );
  },

// AJAX

  createRequestSuccess: function(response){
    console.log(response.success);
    alert("created with success");
  },

  createRequestError: function(response){
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
    })
  }
});

