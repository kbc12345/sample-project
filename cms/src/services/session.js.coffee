angular.module('cms').factory 'Session', 
  ['$resource','$rootScope'
  ($resource, $rootScope) ->


    Session = $resource "/api/session", null,
      {
        login:
          method: 'POST'

        getCurrentUser:
          method: 'GET'
          isArray: false

        logout:
          method: 'DELETE'
      }

    return Session
  ]
