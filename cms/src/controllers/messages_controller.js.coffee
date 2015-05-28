angular.module('cms').controller 'PostsController',
['$scope','$rootScope','Post','$state','$filter','growl'
($scope,$rootScope,Post,$state,$filter,growl) ->

  $rootScope.bodyClass = ""
  $scope.openModal = false
  $scope.previousPageValue = 1

  DEFAULT_PER_PAGE = 10

  $scope.$watch 'metadata.page', ->
    if $scope.metadata isnt undefined && parseInt($scope.previousPageValue) != parseInt($scope.metadata.page)
      $scope.previousPageValue = $scope.metadata.page
      Post.getList(query: $scope.searchParams, page: $scope.metadata.page).$promise
        .then (data) ->
          processData(data)

  $scope.getList = ->
    Post.getList().$promise
      .then (data) ->
        processData(data)

  $scope.search = ->
    $rootScope.startLoading()
    $scope.paginated = false
    $scope.searchParams = $scope.query
    Post.getList(query: $scope.query).$promise
      .then (data) ->
        processData(data)


  $scope.toggleForm =(obj,index)->
    if obj
      $scope.obj =  angular.copy(obj)
      $scope.objIndex = index
    else
      $scope.obj = new Post()
      $scope.obj.is_active = true

    $scope.openModal = !$scope.openModal
    $scope.disabledSubmit = false

  $scope.save =(form)->
    form.$submitted = true
    if form.$valid
      $scope.disabledSubmit = true
      if !$scope.obj.id
        Post.save(unit_type: $scope.obj).$promise
          .then (data) ->
            $scope.obj.id = data.id
            $scope.collection.unshift $scope.obj
            if $scope.collection.length > 10
              $scope.togglePagination()
              $scope.collection.splice(10, 1)
            growl.success(MESSAGE.SAVE_SUCCESS)
            $scope.toggleForm(null)
          .catch (err) ->
            $scope.disabledSubmit = false
      else
        Post.update({id: $scope.obj.id},unit_type: $scope.obj).$promise
          .then (data) ->
            $scope.collection[$scope.objIndex] = $scope.obj
            growl.success(MESSAGE.UPDATE_SUCCESS)
            $scope.toggleForm(null)
          .catch (err) ->
            $scope.disabledSubmit = false
    else
      growl.error(MESSAGE.FORM_ERROR)

  $scope.delete =(obj,index)->
    swal deleteWarning, ->
      $scope.collection.splice(index,1)
      growl.success(MESSAGE.DELETE_SUCCESS)
      Post.remove(id: obj.id)
      if $scope.collection.length is 0
        $scope.collection = null
        $scope.getList()

  processData =(data) ->
    $scope.collection = data.collection
    $scope.metadata = data.metadata
    $scope.togglePagination(data.metadata.count)
    $rootScope.stopLoading()

  $scope.togglePagination =(count)->
    $scope.paginated  = if count > DEFAULT_PER_PAGE then true else false

]
