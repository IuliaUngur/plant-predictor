var ReactMainMenu = React.createClass({
  propTypes: {
    homepage_link: React.PropTypes.string,
    simulation_style: React.PropTypes.string,
    simulation_link: React.PropTypes.string,
    live_prediction_style: React.PropTypes.string,
    live_prediction_link: React.PropTypes.string
  },

  render: function(){
    return (
      <nav className="navbar navbar-default">
        <div className="container-fluid">

          <div className="navbar-header">
            <button className="navbar-toggle collapsed"
                    aria-expanded='false'
                    data-target='#bs-example-navbar-collapse-1'
                    data-toggle='collapse'
                    type='button'>
              <span className="sr-only">Toggle navigation</span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span></button>
            <a className="navbar-brand" href={this.props.homepage_link}>Plant Predictor</a>
          </div>

          <div id="bs-example-navbar-collapse-1" className="collapse navbar-collapse">
            <ul className="nav navbar-nav">
              <li className={this.props.simulation_style}>
                <a aria-expanded='false' aria-haspopup='true' href={this.props.simulation_link} role='button'>
                  Simulation</a>
              </li>
              <li className={this.props.live_prediction_style}>
                <a aria-expanded='false' aria-haspopup='true' href={this.props.live_prediction_link} role='button'>
                  Live Prediction</a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    );
  }
});
