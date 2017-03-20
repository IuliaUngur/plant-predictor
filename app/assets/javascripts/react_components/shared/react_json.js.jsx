var ReactJson = React.createClass({
  propTypes: {
    src: React.PropTypes.string,
    height: React.PropTypes.number
  },

  getInitialState: function(){
    return{
      source: this.props.src
    }
  },

  componentWillReceiveProps(nextProps) {
    this.setState({ source: nextProps.src });
  },

  render: function() {
    var jsonPretty = JSON.stringify(JSON.parse(this.state.source),null,2);
    var style={
      overflowY: 'scroll',
      height: this.props.height
    }

    return <pre className="text-left" style={style}>{jsonPretty}</pre>
  }
});
