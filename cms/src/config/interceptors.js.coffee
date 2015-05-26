angular.module('cms').factory('httpInterceptor', [
  '$q','$rootScope','SweetAlert','$injector','growl'
  ($q, $rootScope, SweetAlert,$injector,growl) ->
    loadingCount = 0

    {
      request: (config) ->
        if ++loadingCount is 1 then $rootScope.$broadcast('loading:progress')
        config or $q.when(config)

      response: (response) ->
        if --loadingCount is 0 then $rootScope.$broadcast('loading:finish')
        response or $q.when(response)

      responseError: (response) ->
        if  --loadingCount is 0 then $rootScope.$broadcast('loading:finish')

        title = response.data.message or 'Oops!'
        message = response.data.error or response.data.errors?.join("\n") or 'Something went wrong'
        #SweetAlert.error title, message
        growl.error(message)
        $q.reject(response)
    }

]).config [
  '$httpProvider'
  ($httpProvider) ->
    $httpProvider.interceptors.push('httpInterceptor')
]

