angular.module(
  'cms',
  []
  )


angular.module('cms').run ($http) ->
  $http.defaults.headers.common.Authorization = localStorage.getItem("AuthToken")

angular.module('cms').controller "PostCatCtrl", ($scope,$http) ->


  # $scope.collection = [
  #   {
  #     name: "zz"
  #     id: 0
  #   }
  #   {
  #     name: "werewr"
  #     id: 1
  #   }
  # ]

  $scope.error = ""
  $scope.currentCat =
    name: ""
    id: null

  $http.get("/api/post_categories")
    .success (data) ->
      $scope.collection = data.collection
    .error (data) ->
      $scope.error = data.error

  $scope.editCat =(obj) ->
    $scope.currentCat = angular.copy obj

  $scope.update =->
    # some logic here to http patch ung category


angular.module('cms').controller "SignInCtrl", ($scope,$http) ->

  $scope.credentials =
    email: ""
    password: ""

  $scope.error = ""

  $scope.calc =
    x: 0
    y: 0
    total: 0

  $scope.add = ->
    $scope.calc.total = parseFloat($scope.calc.x) + parseFloat($scope.calc.y)

  $scope.signIn = ->
    $http.post("/api/session", {credentials: $scope.credentials})
      .success (data) ->
        localStorage.setItem("AuthToken",data.auth_token)
      .error (data) ->
        $scope.error = data.error
