var ReactComponentInformation = React.createClass({
  propTypes: {
    background_path: React.PropTypes.string,
    components_images: React.PropTypes.object,
    components_icons: React.PropTypes.object,
    components_informations: React.PropTypes.object,
  },

  modal: function(sensor) {
    return(
      <div className="modal modal-wide fade" id={sensor} tabIndex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
        <div className="modal-dialog">
          <div className="modal-content">

            <div className="modal-header">
              <button type="button" className="close" data-dismiss="modal">
                <span aria-hidden="true">&times;</span>
                <span className="sr-only">Close</span>
              </button>
              <h4 className="modal-title" id="modalTitle">{sensor} Component</h4>
            </div>

            <div className="modal-body">
              <div className="row">
                <div className="col-md-2 info-bordered-right">
                  <img src={this.props.components_images[sensor]} className="img-responsive"/>
                  <h4>{this.props.components_informations[sensor]}</h4>
                </div>

                <div className="col-md-8">
                  <img src={this.props.background_path} className="img-responsive"/>
                </div>
              </div>
            </div>

            <div className="modal-footer">
              <button type="button" className="btn btn-default" data-dismiss="modal">Close</button>
            </div>

          </div>
        </div>
      </div>
    );
  },

  iconImages:function(){
    return (
      <ul id="rig">
        {
          Object.keys(this.props.components_images).map((sensor,index) =>
            {
              return (
                <li key={index}>
                  <a className="rig-cell" href="#" data-toggle="modal" data-target={"#" + sensor}>
                    <img className="rig-img" src="https://placehold.it/360x260/BABABA"/>
                    <span className="rig-overlay"></span>
                    <span className="rig-text">
                      <span className="fa fa-search-plus fa-3x"/> {sensor}
                    </span>
                  </a>
                  {this.modal(sensor)}
                </li>
              );
            }, this
          )
        }
      </ul>
    );
  },

  render: function(){

    return (
      <div className="container">
        <div className="row text-center">
          <h3>Component Information</h3>
        </div>
        <hr/>
        <div className="row">
          {this.iconImages()}
        </div>
      </div>
    )
  }
});
