angular.module('cms').factory 'Billing', 
  ['$resource','$rootScope'
  ($resource, $rootScope) ->

    
    Billing = $resource "/api/billings/:id", {id: '@id'}, 
      {
        getTerms:
          method: 'GET'
          url: '/api/billings'
          isArray: false

      }

    Billing

  ]