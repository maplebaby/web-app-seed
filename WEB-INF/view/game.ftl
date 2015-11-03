<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />

    <style>
        body {background-color: #000;}
        canvas {position: absolute; top: 0; left: 0; display: block; height: 100%; width: 100%;}  
        a {-webkit-tap-highlight-color: transparent;}
        * {margin:0;padding:0;}
    </style>
    
    <script src="assets/js/jquery/jquery-2.1.4.min.js"></script>
    <script src="assets/js/createjs/createjs-2015.05.21.combined.js"></script>
    <script src="https://code.createjs.com/tweenjs-0.6.1.min.js"></script>
</head>
<body>
        
    <canvas id="J_Game"></canvas>

    <script>

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

        function getRandomColor() {
            return '#'+('00000'+(Math.random()*0x1000000<<0).toString(16)).slice(-6);
        }

        function getRandomNumber(num) {
            return Math.floor(Math.random() * num);
        }

        var stage = new createjs.Stage('J_Game');
        createjs.Touch.enable(stage)

        resizeCanvas();

        var S_W = $(window).get(0).innerWidth * 2;
        var S_H = $(window).get(0).innerHeight * 2;

        /**
         * 图片加载
         */
        var pic  = new createjs.Bitmap("assets/img/app-logo.png");
        pic.addEventListener("click", function(event) {
            createjs.Tween.get(pic, { loop: false })
                .to({ scaleX: .5, scaleY: .5, x: 0, alpha: 0.5 }, 200, createjs.Ease.getPowInOut(1))
                .to({ scaleX: 1, scaleY: 1, x: 0, alpha: 1 }, 200, createjs.Ease.getPowInOut(1));
        });
        pic.x = stage.canvas.width/2 - 325/2;
        pic.y = 0;
        // stage.addChild(pic);

        /**
         * 音效
         */
        createjs.Sound.alternateExtensions = ["mp3"];
        createjs.Sound.on("fileload", function(event) {}, this);
        createjs.Sound.registerSound("assets/audio/Game-Shot.mp3", "sound");

        /**
         * 事件
         */
        var shape = new createjs.Shape();
        shape.graphics.beginFill("#F2F2F2").drawCircle(S_W / 2, S_H - 90, 50);
        stage.addChild(shape);
        createjs.Tween.get(shape, { loop: true })
            .to({ alpha: 0.5}, 600, createjs.Ease.linear)
            .to({ alpha: 1}, 600, createjs.Ease.linear);

        shape.addEventListener("click", function(event) {
            var instance = createjs.Sound.play("sound"); // 播放声音
            instance.on("complete", function(event) {}, this);
            instance.volume = 0.3;

            var c = new createjs.Shape();
            c.alpha = 0;
            c.graphics.beginFill(getRandomColor()).drawCircle(getRandomNumber(S_W - 50 > 50 ? S_W - 50 : 50), getRandomNumber(S_H - 170), 5);
            createjs.Tween.get(c, { loop: true })
                .to({alpha: .5}, 600, createjs.Ease.linear)
                .to({alpha: 1 }, 600, createjs.Ease.linear);

            c.addEventListener('click', function() {
                stage.removeChild(c);
            });
            stage.addChild(c);
        });
        
        /**
         * 文字
         */
        txt = new createjs.Text("•", "30px sans-serif", getRandomColor());
        txt.x = 10;
        txt.y = 150;
        createjs.Tween.get(txt, { loop: true })
            .to({alpha: .5}, 600, createjs.Ease.linear)
            .to({alpha: 1}, 600, createjs.Ease.linear);
        // stage.addChild(txt);

        /**
         * 帧动画
         */
        var grant;
        var img = new Image();
        img.src = "assets/img/test.png";
        img.onload = function() {

            // 定义SpriteSheet
            var ss = new createjs.SpriteSheet({
                "animations": {
                    "run": [0, 5, 'run', 0.4],
                    'jump': [0, 5, 'run', 0.9]
                },
                "images": [img],
                "frames": {
                    "width": 90,
                    "height": 60,
                    
                    "regX": 0,
                    "regY": 0,

                    "count": 6
                }
            });

            grant = new createjs.Sprite(ss, "run");
            grant.x = 50;
            grant.y = 400;
            // stage.addChild(grant);
        };

        stage.update();

        createjs.Ticker.setFPS(60);
        createjs.Ticker.addEventListener("tick", ticker);

        
        var speed = 2;
        function ticker(e) {
            grant.x += speed;
            if(grant.x > stage.canvas.width) {
                grant.x = 0;
                grant.y += 2;
            }
            stage.update();
        }

        stage.addEventListener('stagemousedown', function(e) {
            speed = 4;
            grant.gotoAndPlay("jump");
            requestFullScreen();
        });
        stage.addEventListener('stagemouseup', function(e) {
            speed = 2;
        });

        function resizeCanvas() {
            $("#J_Game").css({
                width: $(window).get(0).innerWidth,
                height: $(window).get(0).innerHeight
            }).attr({
                width: $(window).get(0).innerWidth * 2,
                height: $(window).get(0).innerHeight * 2
            })
            stage.update();
        };
        $(window).resize(resizeCanvas);

        setTimeout(function() {
            window.scrollTop = -1;
        }, 100);

        // document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
        //     WeixinJSBridge.call('hideToolbar');
        //     WeixinJSBridge.call('hideOptionMenu');
        // });
    </script>
</body>
</html>