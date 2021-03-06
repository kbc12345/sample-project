angular.module('cms').config [
  '$stateProvider', '$locationProvider', '$urlRouterProvider','$httpProvider'
  ($stateProvider, $locationProvider, $urlRouterProvider, $httpProvider) ->

    $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise('/cms/login')

    $stateProvider

      .state 'billing',
        url: '/billing',
        controller: 'BillingController',
        templateUrl: 'billing/index.html'
        data:
          unauthenticated: true
          authenticated: true

      .state 'cms',
        url: '/cms',
        controller: 'CmsController',
        templateUrl: 'layouts/cms.html'
        abstract: true

      .state 'cms.login',
        url: '/login',
        controller: 'LoginController',
        templateUrl: 'login/index.html'
        data:
          unauthenticated: true

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
        url: '/{id:int}/edit'
        templateUrl: 'posts/edit.html'
 
       .state 'cms.posts.new',
        url: '/new'
        templateUrl: 'posts/new.html'

      .state 'cms.messages',
        url: '/messages',
        controller: 'MessagesController',
        templateUrl: 'messages/layout.html'
        abstract: true
        data:
          authenticated: true

      .state 'cms.messages.index',
        url: '',
        templateUrl: 'messages/index.html'


      .state 'cms.applicants',
        url: '/applicants',
        controller: 'ApplicantsController',
        templateUrl: 'applicants/layout.html'
        abstract: true
        data:
          authenticated: true

      .state 'cms.applicants.index',
        url: '',
        templateUrl: 'applicants/index.html'

      .state 'cms.terms',
        url: '/terms',
        controller: 'TermsController',
        templateUrl: 'terms/index.html'
        data:
          authenticated: true
  ]
