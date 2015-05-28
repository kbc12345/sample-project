angular.module('cms').factory 'Message', 
  ['$resource','$rootScope'
  ($resource, $rootScope) ->

    
    Post = $resource "/api/messages/:id", {id: '@id'}, 
      {
        getList:
          method: 'GET'
          isArray: false
        update:
          method: 'PATCH'

      }

    Post

  ]