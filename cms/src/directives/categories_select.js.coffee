angular.module('cms').directive 'categoriesSelect', ->
  restrict: 'A'
  replace: true
  templateUrl: 'posts/categories_select.html'
  scope:
    status: "="
    hasObject: "="

  link: ($scope, element) ->
    

    $scope.statusCollection = STATUS_COLLECTION
    if $scope.status is undefined
      $scope.selectedObj = $scope.statusCollection[0]
    else
      $scope.selectedObj = if $scope.status then $scope.statusCollection[0] else $scope.statusCollection[1]


    $scope.updateStatus =(selectedObj)->
      $scope.status = if $scope.hasObject then $scope.selectedObj.value else $scope.selectedObj.value.toString()

   