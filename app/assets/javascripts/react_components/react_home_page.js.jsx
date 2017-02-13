var ReactHomePage = React.createClass({
  getInitialState: function(){
    return{
      title: "Hello"
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
