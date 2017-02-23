var ReactIframe = React.createClass({
  propTypes: {
    access_page: React.PropTypes.string,
    width: React.PropTypes.number,
    height: React.PropTypes.number
  },

  getInitialState: function(){
    return{
      iframe: '<iframe src=\"' + this.props.access_page +
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
