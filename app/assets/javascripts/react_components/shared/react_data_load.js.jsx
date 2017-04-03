var ReactDataLoad = React.createClass({
  propTypes: {
    available_plants: React.PropTypes.array,
    selected_predictions: React.PropTypes.func
  },

  render: function(){
    return(
      <div className="col-lg-10">
        <strong className="pull-left" style={{paddingTop: '5px'}}>
          Select plant for prediction:
        </strong>

        <div className="form-group col-lg-3">
          <select className="form-control" name="plantSelector">
            <option value="">Select plant</option>
            {
              this.props.available_plants.map((value, index) => {
                return <option key={index} value={value}>{value}</option>
              })
            }
          </select>
        </div>

        <div className="col-lg-2">
          <button type="button" className="btn btn-default pull-left" onClick={this.loadPredictions}>
            Load Training Data
          </button>
        </div>

        <div className="col-lg-2" style={{marginLeft: '5px'}}>
          <button type="button" className="btn btn-default pull-left" onClick={this.unloadPredictions}>
            Unload Data
          </button>
        </div>
      </div>
    )
  },

  loadPredictions: function(event){
    event.preventDefault();
    var selection = document.getElementsByName("plantSelector")[0].value;
    this.props.selected_predictions(selection);
  },

  unloadPredictions: function(event){
    event.preventDefault();
    document.getElementsByName("plantSelector")[0].value = ""
    this.props.selected_predictions("");
  }
});
