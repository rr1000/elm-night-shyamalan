var gulp = require('gulp');
var elm = require('gulp-elm');
var gutil = require('gulp-util');
var plumber = require('gulp-plumber');
var connect = require('gulp-connect');

var paths = {
    dest: 'dist',
    elm: 'src/*.elm',
    static: 'src/*.{html,css}'
};

gulp.task('elm-init', elm.init);

gulp.task('elm', ['elm-init'], function(){
    return gulp.src(paths.elm)
        .pipe(plumber())
        .pipe(elm())
        .pipe(gulp.dest(paths.dest));
});

gulp.task('static', function() {
    return gulp.src(paths.static)
        .pipe(plumber())
        .pipe(gulp.dest(paths.dest));
});

gulp.task('watch', function() {
    gulp.watch(paths.elm, ['elm']);
    gulp.watch(paths.static, ['static']);
});

gulp.task('connect', function() {
    connect.server({
        root: 'dist',
        port: 3000
    });
});

gulp.task('build', ['elm', 'static']);
gulp.task('default', ['connect', 'build', 'watch']);
