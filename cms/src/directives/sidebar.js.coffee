angular.module('cms').directive "cmsSidebar", ['Session','$state','localStorageService','$rootScope', (Session,$state,localStorageService,$rootScope) ->
  restrict: "A"
  replace: true
  templateUrl: 'layouts/partials/sidebar.html'

  link: ($scope, element, attrs) ->
    $scope.logout = ->
      Session.logout().$promise
        .then (data) ->
          localStorageService.remove('authToken')
          $rootScope.currentUser = null
          $state.go("cms.login")

]