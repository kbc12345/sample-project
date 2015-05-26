angular.module('cms').controller 'LoginController', 
['$scope','$rootScope','Session','$state','$http','localStorageService'
($scope,$rootScope,Session,$state,$http,localStorageService) ->

  $rootScope.bodyClass = "login-page"

  $scope.credentials = 
    email: ""
    password: ""

  $scope.login = ->
    $scope.showLoading = true
    Session.login({credentials: $scope.credentials}).$promise
      .then (data) ->
        localStorageService.set('authToken', data.auth_token)
        $state.go($scope.afterSuccessPath)
      .catch (err) ->
        $scope.showLoading = false

]
