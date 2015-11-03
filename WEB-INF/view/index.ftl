<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

    <style>
        body { background-color: #FFF;}

        .back {
            transition-property: transform;
            -webkit-transition-property: transform;
            transition-timing-function: cubic-bezier(0, 0, 0.25, 1);
            -webkit-transition-timing-function: cubic-bezier(0, 0, 0.25, 1);
            transition-duration: 350ms;
            -webkit-transition-duration: 350ms;
            transform: translate3d(0, 0, 0px);
            -webkit-transform: translate3d(0, 0, 0px);
        }
           
        canvas { position: absolute; top: 0; left: 0; display: block; height: 100%; width: 100%;}  

        a {
            -webkit-tap-highlight-color: transparent;
        }
        *{margin:0;padding:0;}
        body,canvas,div { -moz-user-select: none;-webkit-user-select: none;-ms-user-select: none;-khtml-user-select: none;-webkit-tap-highlight-color:rgba(0,0,0,0);font-family:Tahoma;}
        html, body { height: 100%; width: 100%; -webkit-tap-highlight-color:rgba(0,0,0,0);}  
        body {
            margin: 0;
            padding: 0;
            font-size: 100%;
        }
        .header {
            width: 100%;
            display: block;
            background-color: #ccc;
        }
        .mask {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            opacity: .5;
            background-color: #000;
        }
        .input {
            display: block;
            margin-left: 5px;
            margin-top: 5px;
            width: .5rem;
            height: .2rem;
            font-size: .1rem;
            border: 1px solid #ccc;
            outline: none;
        }

        .container {
            height: 200px;
        }


        #content {
            width: 100%;
            padding-top: 20px;
            overflow: hidden;
        }
        #content>.scroller {
          display: -webkit-box;
          display: -ms-flexbox;
          display: flex;
        }
        #content>.scroller .page {
          min-width: 100%;
          max-width: 100%;
          display: block;
        }
        #p-summary {
            /*background-color: #546;*/
        }
        #p-desc {
            background-color: #543;
        }
        #p-review {
            background-color: #d33;
        }

        .btn {
            background-color: #FFF;
            border: 1px solid #126aaa;
            border-radius: 3px;
            padding: 3px 10px;
            font-size: 13px;
            color: #126aaa;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
            margin-left: 20px;
        }
        .m-btn:active, .btn.active {
            color: #FFF;
            background-color: #126aaa;
        }
        .scroller {
            transition-property: transform;
            -webkit-transition-property: transform;
            transition-timing-function: cubic-bezier(0, 0, 0.25, 1);
            -webkit-transition-timing-function: cubic-bezier(0, 0, 0.25, 1);
            transition-duration: 350ms;
            -webkit-transition-duration: 350ms;
            transform: translate3d(0px, 0px, 0px);
            -webkit-transform: translate3d(0px, 0px, 0px);
        }
        .scroller-show {
            transition-property: transform;
            -webkit-transition-property: transform;
            transition-timing-function: cubic-bezier(0, 0, 0.25, 1);
            -webkit-transition-timing-function: cubic-bezier(0, 0, 0.25, 1);
            transition-duration: 350ms;
            -webkit-transition-duration: 350ms;
            transform: translate3d(-100%, 0px, 0px);
            -webkit-transform: translate3d(-100%, 0px, 0px);
        }


        .ui-mask {
            display: none;
            background-color: rgba(0, 0, 0, .5);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        .masked .ui-mask {
            display: block;
        }

        .list {

        }
        .list-item {
            height: 100px;
            padding: 5px 10px;
            position: relative;
        }
        .list-item:after {
            content: "";
            position: absolute;
            bottom: -1px;
            left: 0px;
            right: 0px;
            border-bottom: 1px solid #c8c7cc;
            -webkit-transform: scaleY(.5);
            -webkit-transform-origin: 0 0;
        }
        .list-item.active {
            background-color: #ccc;
        }
    </style>
</head>
<body>

    <a href="#" class="btn" data-hover="true" id="J_Trigger">打开</a>

    ${basePath!''}

    <div id="content">
        <div class="scroller" style="">
            <div id="p-summary" class="page" style="height: auto;">

                <a href="javascript:;" class="btn" data-hover="true" id="J_Mask">更新</a><br />

                <a href="javascript:;" class="btn" data-hover="true">打开</a><br />

                <a href="javascript:;" class="btn" data-hover="true">打开</a><br />

                <a href="javascript:;" class="btn m-btn">打开</a><br />



                <ul class="list">
                    <li class="list-item" data-hover="true">
                        fdsfsdfdsfsdf
                    </li>
                    <li class="list-item" data-hover="true">
                        fdsfdsf
                    </li>
                    <li class="list-item" data-hover="true">
                        fdsfdsffsd
                    </li>
                    <li class="list-item" data-hover="true">
                        fsdfdsf
                    </li>
                    <li class="list-item" data-hover="true">
                        sfdsfdsfsdf
                    </li>
                </ul>
             </div>
            
            <div id="p-desc" class="page" style="height: 450px;">
                <div class="container">

                </div>
            </div>
            
            <div id="p-review" class="page" style="height: 450px;">
                <div class="container">

                </div>
            </div>

        </div>
    </div>

    <div class="ui-mask"></div>

    <#-- <iframe id="J_page" src="https://www.baidu.com"></iframe> -->

    <script src="assets/js/jquery/jquery-2.1.4.min.js"></script>
    <script src="assets/js/lib/fastclick.js"></script>
    <script>
        if ('addEventListener' in document) {
            document.addEventListener('DOMContentLoaded', function() {
                FastClick.attach(document.body);
            }, false);


        }

        function requestFullScreen() {
            var de = document.documentElement;
            if (de.requestFullscreen) {
                de.requestFullscreen();
            } else if (de.mozRequestFullScreen) {
                de.mozRequestFullScreen();
            } else if (de.webkitRequestFullScreen) {
                de.webkitRequestFullScreen();
            }
        }
        //退出全屏
        function exitFullscreen() {
            var de = document;
            if (de.exitFullscreen) {
                de.exitFullscreen();
            } else if (de.mozCancelFullScreen) {
                de.mozCancelFullScreen();
            } else if (de.webkitCancelFullScreen) {
                de.webkitCancelFullScreen();
            }
        }

        // $("[data-hover=true]").on("click", function() {
        //     var elem = $(this);
        //     elem.addClass('active');
        //     setTimeout(function() {
        //         elem.removeClass('active');
        //     }, 100);
        // });
        
        $("#J_Trigger").on("click", function() {
            var scroller = $("#content .scroller");
            if(scroller.hasClass('scroller-show')) {
                scroller.removeClass('scroller-show')
            } else {
                scroller.addClass('scroller-show')
            }
            console.log("fdsfsdf");
        });

        $("#J_Mask").on("click", function() {
            showMask();
        });

        function showMask() {
            $("body").addClass("masked");

            $(window).bind("touchmove", function(e) {
                e.preventDefault();
            });

            $(".ui-mask").bind("click", function() {
                hideMask();
            });
        }

        function hideMask() {
            $("body").removeClass("masked");

            $(window).unbind("touchmove");
        }


        function isWeiXin(){
            var ua = window.navigator.userAgent.toLowerCase();
            if(ua.match(/MicroMessenger/i) == 'micromessenger'){
                return true;
            }else{
                return false;
            }
        }
    </script>

    <script src="http://192.168.31.230:8081/target/target-script-min.js#anonymous"></script>

    <!-- <script>
    //  $("#J_Test").tap(function(e) {
    //      alert("dfsfds");
    //      return false;
    //  });

    //  $("#J_Header").tap(function(e) {
    //      alert("header");

    //      return false;
    //  });

    //  $("#J_Input").tap(function(e) {
    //      e.stopImmediatePropagation();
    //      // alert("input");
    //  });
    // </script> -->
</body>
</html>