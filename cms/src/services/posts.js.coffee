angular.module('cms').factory 'Post', 
  ['$resource','$rootScope'
  ($resource, $rootScope) ->

    
    Post = $resource "/api/posts/:id", {id: '@id'}, 
      {
        getList:
          method: 'GET'
          isArray: false
        update:
          method: 'PATCH'

      }

    Post

  ]