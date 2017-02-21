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
  }
});
