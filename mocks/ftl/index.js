'use strict';

var config = require("./common/config");
var mock = {
    view: '/index.ftl',
    out: '/index.html',
    data: {
        slide: [{
            thumbSrc: "/assets/img/index/slideThumb1.jpg",
            picSrc: "/assets/img/index/slideBig.jpg",
            link: "http://baidu.com/",
            background: "#E7E3DA"
        }, {
            thumbSrc: "/assets/img/index/slideThumb2.jpg",
            picSrc: "/assets/img/index/slideBig1.jpg",
            link: "http://baidu.com/",
            background: "#F1F0F6"
        }, {
            thumbSrc: "/assets/img/index/slideThumb3.jpg",
            picSrc: "/assets/img/index/slideBig2.jpg",
            link: "http://baidu.com/",
            background: "#E3E4E9"
        }]
    }
};

module.exports = config(mock);