var ReactSimulationPrototype = React.createClass({
  propTypes: {
    background_path: React.PropTypes.string,
    components_images: React.PropTypes.object,
    components_informations: React.PropTypes.object
  },

  modal() {
    return(
      <div className="modal fade" id="componentsSchema" tabIndex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
        <div className="modal-dialog">
          <div className="modal-content">

            <div className="modal-header">
              <button type="button" className="close" data-dismiss="modal">
                <span aria-hidden="true">&times;</span>
                <span className="sr-only">Close</span>
              </button>
              <h4 className="modal-title" id="modalTitle">Project Schema</h4>
            </div>

            <div className="modal-body">
              <img src={this.props.background_path} className="img-responsive"/>
            </div>

            <div className="modal-footer">
              <button type="button" className="btn btn-primary" data-dismiss="modal">Close</button>
            </div>

          </div>
        </div>
      </div>
    );
  },

  render: function(){
    return (
      <div className="col-sm-8">
        <h3>Components</h3>
        <ul id="rig">
          {
            Object.keys(this.props.components_images).map((sensor,index) => {
              return (
                <li key={index}>
                  <a className="rig-cell" href="#" data-toggle="modal" data-target="#componentsSchema">
                    <img className="rig-img" src={this.props.components_images[sensor]} />
                    <span className="rig-overlay"></span>
                    <span className="rig-text">{this.props.components_informations[sensor]}</span>
                  </a>
                </li>
              )
            }, this)
          }
        </ul>
        {this.modal()}
      </div>
    );
  }
});
