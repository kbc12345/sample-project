angular.module('cms').factory 'Category', 
  ['$resource','$rootScope'
  ($resource, $rootScope) ->

    
    Category = $resource "/api/post_categories/:id", {id: '@id'}, 
      {
        getList:
          method: 'GET'
          isArray: false
        update:
          method: 'PATCH'

      }

    Category

  ]