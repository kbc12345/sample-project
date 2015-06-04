angular.module('cms').controller 'PostsController',
['$scope','$rootScope','Post','$state','$filter','growl','Category'
($scope,$rootScope,Post,$state,$filter,growl,Category) ->

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

    Category.getList().$promise
      .then (data) ->
        $scope.categories = data.collection

  $scope.newPost = ->
    $rootScope.stopLoading()
    $scope.post = 
      content: null
      status: STATUS_COLLECTION[1]
      excerpt: null
      title: ""
      posted_date: moment(new Date())

    Category.getList().$promise
      .then (data) ->
        $scope.categories = data.collection

  $scope.getObj = ->
    Post.get(id: $state.params.id).$promise
      .then (data) ->
        $scope.post = data.post
        $scope.post.posted_date = moment($scope.post.posted_date)
        $scope.categories = data.categories
        $scope.post.post_category_id = findById($scope.post.post_category_id, $scope.categories)
        $rootScope.stopLoading()
      .catch (err) ->
        $state.go("cms.posts.index")

  $scope.save = ->
    obj = angular.copy $scope.post
    obj.post_category_id = $scope.post.post_category_id.id if !!$scope.post.post_category_id

    if !!$scope.post.id
      $scope.update(obj)
    else
      $scope.create(obj)

  $scope.create =(obj)->
    growl.success(MESSAGE.SAVE_SUCCESS)
    Post.save(post: obj).$promise
      .then (data) ->
        $state.go("cms.posts.index")
      .catch (err) ->
        $scope.disabledSubmit = false


  $scope.update =(obj)->
    growl.success(MESSAGE.UPDATE_SUCCESS)
    Post.update({id: obj.id}, post: obj).$promise
      .then (data) ->
        $scope.disabledSubmit = false
      .catch (err) ->
        $scope.disabledSubmit = false

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

  $scope.toggleForm =(obj)->
    if !!obj
      $scope.post_category = angular.copy obj
    else
      $scope.post_category = new Category()

    $scope.disabledSubmit = false
    $scope.openModal = !$scope.openModal

  $scope.feature =(obj) ->
    obj.featured = !obj.featured
    Post.update({id: obj.id}, post: obj).$promise

  $scope.saveCategory = (form) ->
    form.$submitted = true
    if form.$valid
      $scope.disabledSubmit = true
      if !$scope.post_category.id
        Category.save(post_category: $scope.post_category).$promise
          .then (data) ->
            $scope.post_category.id = data.id
            $scope.categories.unshift $scope.post_category
            growl.success(MESSAGE.SAVE_SUCCESS)
            $scope.toggleForm(null)
          .catch (err) ->
            $scope.disabledSubmit = false
      else
        Category.update({id: $scope.post_category.id},post_category: $scope.post_category).$promise
          .then (data) ->
            $scope.categories[$scope.objIndex] = $scope.post_category
            growl.success(MESSAGE.UPDATE_SUCCESS)
            $scope.toggleForm(null)
          .catch (err) ->
            $scope.disabledSubmit = false

    else
      growl.error(MESSAGE.FORM_ERROR)
  
  $scope.deleteCategory =(obj,index)->
    swal deleteWarning, ->
      $scope.categories.splice(index,1)
      growl.success(MESSAGE.DELETE_SUCCESS)
      Category.remove(id: obj.id)

  $scope.moveDown =(obj,index) ->
    if index+1 < $scope.collection.length
      $scope.collection.splice(index,1)
      $scope.collection.splice(index+1,0,obj)

  $scope.moveUp =(obj,index) ->
    if index != 0
      $scope.collection.splice(index,1)
      $scope.collection.splice(index-1,0,obj)



]
