angular.module('cms').controller 'LoginController', 
['$scope','$rootScope','Session','$state','$http','localStorageService'
($scope,$rootScope,Session,$state,$http,localStorageService) ->

  $rootScope.bodyClass = "login-page"

  $scope.credentials = 
    email: ""
    password: ""


  $scope.signin = ->
    $scope.disabledSubmit = true

    Session.login({credentials: $scope.credentials}).$promise
      .then (data) ->
        localStorageService.set('authToken', data.auth_token)
        $state.go("cms.posts.index")
      .catch (err) ->
        $scope.disabledSubmit = false



]
