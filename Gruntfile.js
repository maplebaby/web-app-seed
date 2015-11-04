/**
 * 移动手机项目
 */
'use strict';
var fs = require('fs');
var os = require('os');
var path = require("path");

function getIP() {
    var info = os.networkInterfaces()["en0"] || os.networkInterfaces()["本地连接"];
    for(var i=0, len=info.length; i<len; i++) {
        var item = info[i];
        if(item.family == "IPv4") {
            return item.address;
        }
    }
    return "127.0.0.1";
}

module.exports = function(grunt) {

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        clean: {
            tmp: {
                options: {
                    force: true
                },
                src: ['./.tmp']
            }
        },

        /**
         * 编译less
         */
        less: {
            compile: {
                options: {
                    cleancss: true
                },
                files: [{
                    expand: true,
                    cwd: './assets/less',
                    src: ['*.less'],
                    dest: './.tmp/assets/css',
                    ext: '.css'
                }]
            }
        },

        copy: {
            tmp: {
                files: [{
                    expand: true,
                    src: ['./assets/js/**/*', './assets/img/**/*', './assets/audio/**/*'],
                    dest: './.tmp'
                }]
            },

            /* 静态服务器支持html */
            html: {
                files: [{
                    expand: true,
                    src: ['./html/**/*'],
                    dest: './.tmp'
                }]
            }
        },

        /**
         * 把ftl生成html
         */
        freemarker: {
            options: {
                views: "WEB-INF/view",
                out: "./.tmp"
            },
            compile: {
                src: ["mocks/ftl/**/*.js", "!mocks/ftl/common/*.js"]
            }
        },

        /**
         * 静态服务器
         */
        connect: {
            options: {
                port: 9000,
                hostname: getIP(),
                livereload: 35729,
                middleware: function(connect, options, middlewares) {
                    middlewares.unshift(function(req, res, next) {
                        if (req.url.indexOf('.json') != -1) {
                            var mock = grunt.file.readJSON('mocks/ajax/api.json');

                            if (mock[req.url]) {
                                res.end(JSON.stringify(mock[req.url]));
                            } else {
                                res.end('{}');
                            }
                        } else {
                            return next();
                        }
                    });

                    return middlewares;
                }
            },

            server: {
                options: {
                    open: true,
                    base: ['.tmp']
                }
            }
        },

        /**
         * 文件变更监听
         */
        watch: {
            livereload: {
                options: {
                    livereload: '<%=connect.options.livereload%>'
                },
                files: [
                    '.tmp/**/*'
                ]
            },
            assets: {
                files: ['./assets/js/**/*', './assets/img/**/*', './assets/audio/**/*'],
                tasks: ['copy:tmp']
            },
            less: {
                files: ['./assets/less/*.less'],
                tasks: ['less:compile']
            },
            mock: {
                files: ["./mock/ftl/**/*.js"],
                tasks: ['freemarker:compile']
            },
            html: {
                files: ['./html/**/*.html'],
                tasks: ['copy:html']
            },
            ftl: {
                files: ['./WEB-INF/view/**/*.ftl'],
                tasks: ['freemarker:compile']
            }
        }
    });

    grunt.loadNpmTasks('grunt-express');
    grunt.loadNpmTasks('grunt-freemarker');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-connect');

    grunt.registerTask('default', ["serve"]);

    // 清空.tmp -> less编译 -> 复制js、img -> ftl编译 -> 启动静态资源服务器 -> 文件监听livereload
    grunt.registerTask('serve', ["clean:tmp", "less:compile", "copy:tmp", "copy:html", "freemarker:compile", "connect:server", "watch"]);
};
