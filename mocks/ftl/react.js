'use strict';

var config = require("./common/config");
var mock = {
    view: '/react.ftl',
    out: '/react.html',
    data: {}
};

module.exports = config(mock);