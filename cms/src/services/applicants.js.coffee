angular.module('cms').factory 'Applicant', 
  ['$resource','$rootScope'
  ($resource, $rootScope) ->

    
    Applicant = $resource "/api/applicants/:id", {id: '@id'}, 
      {
        getList:
          method: 'GET'
          isArray: false
        update:
          method: 'PATCH'

      }

    Applicant

  ]