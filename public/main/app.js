var PostsApp = angular.module('PostsApp', ['ngAnimate', 'ngRoute'])
    .config(function ($routeProvider) {
        $routeProvider
        .when('/posts', {
            templateUrl: 'views/posts.html'
        })
        .when('/tags', {
            templateUrl: 'views/tags.html'
        })
        .otherwise({
            redirectTo: '/posts'
        });
    });