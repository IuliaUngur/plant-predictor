var ReactHomePage = React.createClass({
  slider: function(){
    return(
      <div className="container-fluid slider-container">
        <div id="slider" className="carousel slide" data-ride="carousel">
          <ol className="carousel-indicators">
            <li data-target="#slider" data-slide-to="0" className="active"></li>
            <li data-target="#slider" data-slide-to="1"></li>
            <li data-target="#slider" data-slide-to="2"></li>
            <li data-target="#slider" data-slide-to="3"></li>
          </ol>

          <div className="carousel-inner" role="listbox">
            <div className="item active">
              <img src="https://placehold.it/2048x1024"/>
            </div>

            <div className="item">
              <img src="https://placehold.it/2048x1024"/>
            </div>

            <div className="item">
              <img src="https://placehold.it/2048x1024"/>
            </div>

            <div className="item">
              <img src="https://placehold.it/2048x1024"/>
            </div>
          </div>

          <a className="left carousel-control" href="#slider" role="button" data-slide="prev">
            <span className="fa fa-angle-left slider-icons" aria-hidden="true"/>
          </a>
          <a className="right carousel-control" href="#slider" role="button" data-slide="next">
            <span className="fa fa-angle-right slider-icons" aria-hidden="true"/>
          </a>
        </div>
      </div>
    );
  },

  technologies: function(){
    var style= {
      width: '100%'
    };
    return(
      <div className="container text-center">
        <h3>Technologies</h3><br/>
        <div className="row">
          <div className="col-sm-4">
            <img src="https://placehold.it/150x80" className="img-responsive" style={style} alt="Image"/>
            <p>Ruby On Rails</p>
            <div className="well">
            <p>Some text..</p>
            </div>
          </div>
          <div className="col-sm-4">
            <img src="https://placehold.it/150x80" className="img-responsive" style={style} alt="Image"/>
            <p>ReactJS</p>
            <div className="well">
            <p>Some text..</p>
            </div>
          </div>
          <div className="col-sm-4">
            <img src="https://placehold.it/150x80" className="img-responsive" style={style} alt="Image"/>
            <p>Arduino</p>
            <div className="well">
            <p>Some text..</p>
            </div>
          </div>
        </div>
      </div>
    );
  },

  footer: function(){
    return(
      <footer className="container-fluid text-center">
        <p>Footer Text</p>
      </footer>
    );
  },

  render: function(){
    return (
      <div>
        {this.slider()}
        {this.technologies()}
        <br/>
        {this.footer()}
      </div>
    );
  }
});
