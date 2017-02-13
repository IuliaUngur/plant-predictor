var ReactHomePage = React.createClass({
  getInitialState: function(){
    return{
      title: "Hello"
    }
  },

  render: function(){
    return (
      <div className="container">
        <br/>
        <div id="slider" className="carousel slide" data-ride="carousel">
          <ol className="carousel-indicators">
            <li data-target="#slider" data-slide-to="0" className="active"></li>
            <li data-target="#slider" data-slide-to="1"></li>
            <li data-target="#slider" data-slide-to="2"></li>
            <li data-target="#slider" data-slide-to="3"></li>
          </ol>

          <div className="carousel-inner" role="listbox">
            <div className="item active">
              <img src="https://placehold.it/460x345" width="460" height="345"/>
            </div>

            <div className="item">
              <img src="https://placehold.it/460x345" width="460" height="345"/>
            </div>

            <div className="item">
              <img src="https://placehold.it/460x345" width="460" height="345"/>
            </div>

            <div className="item">
              <img src="https://placehold.it/460x345" width="460" height="345"/>
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
  }
});
