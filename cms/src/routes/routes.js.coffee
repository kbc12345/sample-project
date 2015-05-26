angular.module('cms').config [
  '$stateProvider', '$locationProvider', '$urlRouterProvider','$httpProvider'
  ($stateProvider, $locationProvider, $urlRouterProvider, $httpProvider) ->

    $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise('/cms/login')

    $stateProvider
      .state 'cms',
        url: '/cms',
        controller: 'CmsController',
        templateUrl: 'layouts/cms.html'
        abstract: true

      .state 'cms.login',
        url: '/login',
        controller: 'LoginController',
        templateUrl: 'login/index.html'


      .state 'cms.posts',
        url: '/posts',
        controller: 'PostsController',
        templateUrl: 'posts/layout.html'
        abstract: true
        data:
          authenticated: true

      .state 'cms.posts.index',
        url: '',
        templateUrl: 'posts/index.html'

      .state 'cms.posts.edit',
        url: '/{id:int}'
        templateUrl: 'posts/index.html'
 


  ]
