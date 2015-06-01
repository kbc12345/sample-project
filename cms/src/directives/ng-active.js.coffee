angular.module('cms').directive 'ngActiveSelect', ->
  restrict: 'A'
  replace: true
  templateUrl: 'layouts/partials/active_select.html'
  scope:
    status: "="
    hasObject: "="

  link: ($scope, element) ->
    
    if $scope.hasObject
      $scope.statusCollection = STATUS_COLLECTION
      if $scope.status is undefined
        $scope.selectedObj = $scope.statusCollection[0]
      else
        $scope.selectedObj = if $scope.status then $scope.statusCollection[0] else $scope.statusCollection[1]
    else
      $scope.statusCollection = STATUS_COLLECTION_ALL 
      $scope.selectedObj = $scope.statusCollection[0]
      
 
    $scope.updateStatus =(selectedObj)->
      $scope.status = if $scope.hasObject then $scope.selectedObj.value else $scope.selectedObj.value.toString()

   