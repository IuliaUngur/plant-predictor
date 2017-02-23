var ReactPredictionTable = React.createClass({
  propTypes: {
    predictions: React.PropTypes.array
  },

  render: function() {
    var tableContent = this.props.predictions.map((prediction, index) => {
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
  }
});
