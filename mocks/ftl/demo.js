'use strict';

var config = require("./common/config");
var mock = {
    view: '/demo.ftl',
    out: '/demo.html',
    data: {}
};

module.exports = config(mock);