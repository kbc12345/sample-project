angular.module('cms').controller 'MessagesController',
['$scope','$rootScope','Message','$state','$filter','growl'
($scope,$rootScope,Message,$state,$filter,growl) ->

  $scope.previousPageValue = 1
  $rootScope.bodyClass = ""
  
  DEFAULT_PER_PAGE = 10

  $scope.$watch 'metadata.page', ->
    if $scope.metadata isnt undefined && parseInt($scope.previousPageValue) != parseInt($scope.metadata.page)
      $scope.previousPageValue = $scope.metadata.page
      Message.getList(query: $scope.searchParams, page: $scope.metadata.page).$promise
        .then (data) ->
          processData(data)


  $scope.getList = ->
    Message.getList().$promise
      .then (data) ->
        processData(data)

  processData =(data) ->
    $scope.collection = data.collection
    $scope.metadata = data.metadata
    $scope.togglePagination(data.metadata.count)
    $rootScope.stopLoading()

  $scope.togglePagination =(count)->
    $scope.paginated  = if count > DEFAULT_PER_PAGE then true else false

  $scope.delete =(obj,index)->
    swal deleteWarning, ->
      $scope.collection.splice(index,1)
      growl.success(MESSAGE.DELETE_SUCCESS)
      Message.remove(id: obj.id)
      if $scope.collection.length is 0
        $scope.collection = null
        $scope.getList()


]
