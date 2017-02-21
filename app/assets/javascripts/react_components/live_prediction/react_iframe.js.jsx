var ReactIframe = React.createClass({
	iframe: function () {
    	return {
        	__html: this.props.iframe
        }
    },

    render: function() {
        return <div>
        	<div dangerouslySetInnerHTML={ this.iframe() } />
        </div>;
    }
});
