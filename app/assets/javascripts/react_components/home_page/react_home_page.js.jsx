var ReactHomePage = React.createClass({
  propTypes: {
    homepagePaths: React.PropTypes.object
  },

  slider: function(){
    return(
      <div className="container-fluid">
        <div id="slider" className="carousel slide" data-ride="carousel">
          <ol className="carousel-indicators">
            <li data-target="#slider" data-slide-to="0" className="active"></li>
            <li data-target="#slider" data-slide-to="1"></li>
            <li data-target="#slider" data-slide-to="2"></li>
            <li data-target="#slider" data-slide-to="3"></li>
          </ol>

          <div className="carousel-inner" role="listbox">
            <div className="item active">
              <img src={this.props.homepagePaths.slideshow1}/>
            </div>

            <div className="item">
              <img src={this.props.homepagePaths.slideshow2}/>
            </div>

            <div className="item">
              <img src={this.props.homepagePaths.slideshow3}/>
            </div>

            <div className="item">
              <img src={this.props.homepagePaths.slideshow4}/>
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
    return(
      <div className="container text-center technology-container" >
        <h3>Technologies</h3><br/>
        <div className="row">
          <div className="col-sm-4">
            <img src={this.props.homepagePaths.ruby} className="img-responsive technology-image"/>
            <p><strong>Ruby On Rails</strong></p>
            <div className="well">
              <p>MVC and server-side web application framework, for and written in Ruby,
                providing default structures like a database, web services and web pages.</p>
              <p>(source:
                <a href="https://en.wikipedia.org/wiki/Ruby_on_Rails">Wiki</a>,
                <a href="http://rubyonrails.org/">Rails</a>)</p>
            </div>
          </div>
          <div className="col-sm-4">
            <img src={this.props.homepagePaths.react} className="img-responsive technology-image"/>
            <p><strong>ReactJS</strong></p>
            <div className="well">
              <p>Open-source Javascript library for building user interfaces - corresponding to
                View in the MVC model.</p>
              <p>(source: <a href="https://facebook.github.io/react/">React</a>)</p>
            </div>
          </div>
          <div className="col-sm-4">
            <img src={this.props.homepagePaths.arduino} className="img-responsive technology-image"/>
            <p><strong>Arduino</strong></p>
            <div className="well">
              <p>Microcontroller board that can be easily connected to a computer with a USB.
                Typically programmed using a dialect of features from C and C++.
              </p>
              <p>(source:
                <a href="https://en.wikipedia.org/wiki/Arduino">Wiki</a>,
                <a href="https://www.arduino.cc/">Arduino</a>)</p>
            </div>
          </div>
        </div>
      </div>
    );
  },

  footer: function(){
    return(
      <footer className="container-fluid text-center footer-styling">
        <p>Bachelor degree, Student: <strong>Ungur Iulia</strong>,
        Supervisor: <strong>Assoc. Prof. Adrian Groza</strong></p>
        <p>Faculty of Automation and Computer Science,
            Computer Science Department, Technical University Of Cluj-Napoca, Romania</p>
        <p><a href="https://github.com/IuliaUngur/plant-predictor">Source code</a></p>
        <p><strong>2016-2017</strong></p>
      </footer>
    );
  },

  render: function(){
    return (
      <div>
        {this.slider()}
        {this.technologies()}
        <br/><br/><br/><br/>
        {this.footer()}
      </div>
    );
  }
});
