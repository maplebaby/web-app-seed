'use strict';

var config = require("./common/config");
var mock = {
    view: '/game.ftl',
    out: '/game.html',
    data: {}
};

module.exports = config(mock);