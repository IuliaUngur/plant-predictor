var ReactIframe = React.createClass({
  propTypes: {
    src: React.PropTypes.string,
    width: React.PropTypes.string,
    height: React.PropTypes.string
  },

  getInitialState: function(){
    return{
      iframe: '<iframe src=\"' + this.props.src +
        '\" width="' + this.props.width +
        '" height="' + this.props.height +
        '"></iframe>'
    }
  },

  iframe: function () {
    return {
      __html: this.state.iframe
    }
  },

  render: function() {
    return <div>
      <div dangerouslySetInnerHTML={ this.iframe() } />
    </div>;
  }
});
