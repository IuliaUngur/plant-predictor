var ReactLivePrediction = React.createClass({
  propTypes: {
    title: React.PropTypes.string
  },

  getInitialState: function(){
    return{
      title: this.props.title
    }
  },

  render: function(){
    return (
      <div>
        <span className="h1">
          {this.state.title}
        </span>
      </div>
    );
  }
});