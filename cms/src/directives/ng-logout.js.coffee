angular.module('cms').directive "ngLogout", ['Session','$state','localStorageService','$rootScope', (Session,$state,localStorageService,$rootScope) ->
  restrict: "A"
  replace: true
  template: '<li>
                <a ng-click="logout()">
                <i class="icon icon-sun"></i>
                </a>
            </li>'

  link: ($scope, element, attrs) ->
    $scope.logout = ->
      Session.logout().$promise
        .then (data) ->
          localStorageService.remove('authToken')
          $rootScope.currentUser = null
          $state.go("cms.login")

]