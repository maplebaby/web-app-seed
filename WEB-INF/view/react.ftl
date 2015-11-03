<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

  <style>
    .toast {
      padding: 5px 10px;
      background-color: #000;
      border-radius: 3px;
      color: #FFF;
      font-size: 12px;
      display: inline-block;
      opacity: .8;
    }
    .hide {
      display: inline-block;
      opacity: 0;
      transition: opacity .5s;
      -webkit-transition: opacity .5s;
    }
    #J_Name {
      position: fixed;
      width: 100%;
      bottom: 20px;
      text-align: center;
    }
  </style>
</head>
<body>
  <div id="example"></div>
  <div id="J_Name"></div>

  <div id="div1"></div>
  <div id="div2"></div>

  <input type="text" value="fdfd" />

  <div id="input"></div>

  <script src="assets/js/react/react.js"></script>
  <script src="assets/js/react/JSXTransformer.js"></script>
  <script src="assets/js/jquery/jquery-2.1.4.min.js"></script>

  <script type="text/jsx">
    var CommonList = React.createClass({
      getInitialState: function() {
        return {
          datas: this.props.datas
        };
      },

      loading: function() {
        var arr = this.props.datas.push({"name": "maple"});
        this.setState({
          datas: arr
        });
      },

      componentDidMount: function() {
        setInterval(this.loading, 100);
      },

      render: function() {
        var rows = [];

        this.props.datas.forEach(function(data) {
          rows.push(<p>{data.name}</p>);
        });

        return (
          <div>
            <p style={{color: "red"}}>{this.props.title}</p>
            {rows}
          </div>
        );
      }
    });
  </script>

  <script type="text/jsx">
    var datas = [{"name": "job"}, {"name": "sans"}, {"name": "math"}];

    // React.render(
    //   <CommonList title="test" datas={datas} />,
    //   document.getElementById('example')
    // );


    React.render(
      <input type="text" defaultValue="test" />,
      document.getElementById('input')
    );

    /**
     * 生命周期
     */
    var NotesList = React.createClass({
      getDefaultProps: function() {
        console.log("getDefaultProps");
        return {};
      },

      getInitialState: function() {
        console.log("geyInitialState");
        return {};
      },

      componentWillMount: function() {
        console.log("componentWillMount");
      },

      render: function() {
        console.log("render");
        return (
          <div>hello <strong>{this.props.name}</strong></div>
        );
      },

      componentDidMount: function() {
        console.log("componentDidMount");
      },

      componentWillRecieveProps: function() {
        console.log("componentWillRecieveProps");
      },
    
      componentWillUpdate: function() {
        console.log("componentWillUpdate");
      },
        
      componentDidUpdate: function() {
        console.log("componentDidUpdate");
      },

    });

    var list1 = React.render(<NotesList name='aaa'></NotesList>, document.getElementById("div1"));
    list1.setProps({name: "ccc"});

    var list2 = React.render(<NotesList name='bbb'></NotesList>, document.getElementById("div2"));

    
    /**
     * 切面
     */
    var TimerMixin = function() {
      return {
        componentDidMount: function() {
          this._interval = setInterval(this._onTick, 1000);
        },
        format: function(d) {
          return d >= 10 ? d : ("0"+d);
        },
        _onTick: function() {
          var d = new Date();
          this.timerTick(this.format(d.getHours()) + ":" + this.format(d.getMinutes()) + ":" + this.format(d.getSeconds()));
        },
        componentWillUnmount: function() {
          clearInterval(this._interval);
        }
      }
    };

    var Card = React.createClass({
      mixins: [
        TimerMixin()
      ],
      timerTick: function(t) {
        this.setState({
          time: t
        });
      },
      getInitialState: function() {
        return {
          time: 'loading time...'
        }
      },
      render: function() {
        return (
          <div>你好 {this.props.name}！现在是北京时间：{this.state.time}。</div>
        );
      }
    });

    var card1 = React.render(<Card name='maple'></Card>, document.getElementById("div1"));
  </script>
</body>
</html>