var ReactSensorInputs = React.createClass({
  propTypes: {
    predictions: React.PropTypes.array,
    sensor_values: React.PropTypes.object,
    submit_function: React.PropTypes.func
  },

  inputType: function(type, sensor, min, max){
    if(type=="select"){
      return <select className="form-control" name={sensor}>
          {
            this.props.sensor_values[sensor].map((value, index) => {
              return <option key={index} value={value}>{value}</option>
            })
          }
        </select>
    }
    else{
      return <input type="number" className="form-control" name={sensor} required="true" min={min} max={max}/>
    }
  },

  sensorOptions: function(type, label, sensor, min=0, max=''){
    return (
      <div className="col-lg-2">
        <div className="form-group">
          <label>{label}</label>
          {this.inputType(type, sensor, min, max)}
        </div>
      </div>
    );
  },

  render: function(){
    return(
      <form className="form-inline" name="sensorForm" onSubmit={this.props.submit_function}>
        <div className="row">

          {this.sensorOptions("select","Light:","light")}
          {this.sensorOptions("input","Temperature (C):","temperature")}
          {this.sensorOptions("input","Distance (cm):","distance")}
          {this.sensorOptions("select","Rain:","raindrop")}
          {this.sensorOptions("input","Humidity (%):","humidity",0,100)}
          {this.sensorOptions("input","Vibration:","vibration",0,1000)}

          <div className="col-lg-1">
            <div className="form-group">
              <br/>
              <button className="btn btn-default fa fa-plus" type="submit"/>
            </div>
          </div>
        </div>
        <br/>
      </form>
    );
  }
});
