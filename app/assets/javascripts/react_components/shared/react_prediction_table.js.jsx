var ReactPredictionTable = React.createClass({
  propTypes: {
    predictions: React.PropTypes.array
  },

  getInitialState: function(){
    return{
      predictions: this.props.predictions
    }
  },

  render: function() {
    var tableContent = this.state.predictions.map((prediction, index) => {
      return <tr key={index}>
               <td>{prediction.light}</td>
               <td>{prediction.temperature}</td>
               <td>{prediction.distance}</td>
               <td>{prediction.raindrop}</td>
               <td>{prediction.humidity}</td>
               <td>{prediction.vibration}</td>
               <td className="col-md-3">
                 <div className="col-md-10">
                    <input
                      type="text"
                      className="form-control"
                      placeholder={prediction.result}
                      id={"result"+ prediction.id}
                    />
                  </div>
                  <div className="col-md-2">
                    <span className="fa fa-check btn" onClick={()=> this.updatePrediction(prediction.id)}/>
                  </div>
               </td>
             </tr>
    });

    return(
      <table className="table table-striped table-bordered margin-top-20">
        <thead>
          <tr>
            <th className="text-center">Light</th>
            <th className="text-center">Temperature</th>
            <th className="text-center">Distance</th>
            <th className="text-center">Rain Quantity</th>
            <th className="text-center">Humidity</th>
            <th className="text-center">Vibrations</th>
            <th className="text-center">Algorithm Outcome</th>
          </tr>
        </thead>
        <tbody>
          {tableContent}
        </tbody>
      </table>
    );
  },

  requestSuccess: function(response){
    document.getElementById("result" + response.success.id).value = "";
    updatedPredictions = this.state.predictions;

    var index = this.state.predictions.findIndex(
      function(prediction) {
        return prediction.id == response.success.id;
      }
    );
    updatedPredictions[index] = response.success;

    this.setState({ predictions: updatedPredictions });
  },

  requestError: function(response){
    alert(response.responseJSON.error);
  },

  updatePrediction: function(id){
    var value = document.getElementById("result" + id).value;
    $.ajax({
      type: 'PUT',
      url: '/predictions/' + id,
      data: { result: value },
      success: this.requestSuccess,
      error: this.requestError
    });
  }
});
