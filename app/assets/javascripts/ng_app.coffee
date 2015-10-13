angular.module(
  'cms',
  []
  )


angular.module('cms').run ($http) ->
  $http.defaults.headers.common.Authorization = "abc"
  #$http.defaults.headers.common.Authorization = localStorage.getItem("AuthToken")

angular.module('cms').controller "PostCatCtrl", ($scope,$http,$window) ->


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

  $scope.errors = []
  $scope.currentCat =
    name: ""
    id: null
  
  currentIndex = -1
  $scope.action = ""

  $scope.total_page = [1]
  $scope.currentPage = 1

  $http.get("/api/post_categories")
    .success (data) ->
      $scope.collection = data.collection
      $scope.total_page = [1..data.metadata.total_page]
    .error (data) ->
      $scope.error = data.error

  $scope.switchToPage =(pageNumber) ->
    $scope.currentPage = pageNumber
    $http.get("/api/post_categories", params: {page: pageNumber})
    .success (data) ->
      $scope.collection = data.collection
    .error (data) ->
      $scope.error = data.error

  $scope.deleteCat =(obj, index) ->
    if $window.confirm("are you sure?")
      $scope.action = "delete"
      $http.delete("api/post_categories/#{obj.id}")
        .success (data) ->
          $scope.collection.splice(index, 1)
          $http.get("/api/post_categories", params: {page: $scope.currentPage})
          .success (data) ->
            $scope.collection = data.collection
            $scope.total_page = [1..data.metadata.total_page]
          .error (data) ->
            $scope.error = data.error

  $scope.editCat =(obj,index) ->
    $scope.currentCat = angular.copy obj
    currentIndex = index
    $scope.action = "edit"

  $scope.addCat = ->
    $scope.action = "add"
    $scope.currentCat.name = ""

  $scope.add = ->
    $http.post("/api/post_categories", post_category: {name: $scope.currentCat.name})
      .success (data) ->
        $scope.errors = []
        $scope.action= ""
        $scope.currentPage= 1
        $http.get("/api/post_categories")
          .success (data) ->
            $scope.collection = data.collection
            $scope.total_page = [1..data.metadata.total_page]
          .error (data) ->
            $scope.error = data.error
      .error (data) ->
        $scope.errors = data.errors

  $scope.update =->
    $http.patch("/api/post_categories/#{$scope.currentCat.id}", post_category: {name: $scope.currentCat.name})
      .success (data) ->
        $scope.collection[currentIndex].name = $scope.currentCat.name
        $scope.currentCat.id = null
        $scope.action= ""
        $scope.errors = []
      .error (data) ->
        $scope.errors = data.errors

angular.module('cms').controller "SignInCtrl", ($scope,$http) ->

  $scope.credentials =
    email: ""
    password: ""

  $scope.error = ""

  $scope.calc =
    x: 0
    y: 0
    total: 0

  $scope.signIn = ->
    $http.post("/api/session", {credentials: $scope.credentials})
      .success (data) ->
        localStorage.setItem("AuthToken",data.auth_token)
      .error (data) ->
        $scope.error = data.error
