var ReactSensorInputs = React.createClass({
  propTypes: {
    predictions: React.PropTypes.array,
    sensor_values: React.PropTypes.object,
    submit_function: React.PropTypes.func
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

  render: function(){
    return(
      <div className="container-fluid text-left">
        <form name="sensorForm" onSubmit={this.props.submit_function}>
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
  }
});
