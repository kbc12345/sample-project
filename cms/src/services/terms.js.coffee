angular.module('cms').factory 'Terms', 
  ['$resource','$rootScope'
  ($resource, $rootScope) ->

    
    Terms = $resource "/api/terms/:id", {id: '@id'}, 
      {
        getTerms:
          method: 'GET'
          url: '/api/terms'
          isArray: false
        update:
          method: 'PATCH'
      }

    Terms

  ]