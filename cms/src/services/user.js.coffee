angular.module('cms').factory 'User', 
  ['$resource','$rootScope'
  ($resource, $rootScope) ->

    
    User = $resource "/api/users/:id", {id: '@id'}, 
      {
        getList:
          method: 'GET'
          isArray: false
        update:
          method: 'PATCH'

      }

    User

  ]