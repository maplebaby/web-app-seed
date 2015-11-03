var Toast = React.createClass({displayName: "Toast",
  getInitialState: function() {
    return {
      text: this.props.text || "默认提示"
    };
  },

  componentDidMount: function() {
    var self = this;

    this.timer = setTimeout(function() {
      $(React.findDOMNode(self.refs.toast)).addClass('hide');
    }, 1000);
  },

  componentDidUpdate: function(prev, next) {
    var self = this;
    var elem = $(React.findDOMNode(self.refs.toast));
    if(this.timer) {
      elem.removeClass('hide');
      clearTimeout(this.timer);
    }

    this.timer = setTimeout(function() {
      elem.addClass('hide');
    }, 1000);
  },

  render: function() {
    return (
      React.createElement("span", {ref: "toast", className: "toast"}, 
        this.props.text
      )
    );
  }
});