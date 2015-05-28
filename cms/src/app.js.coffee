cms = angular.module(
  'cms',
  [
    'ui.router',
    'templates',
    'ngResource',
    'ngAnimate',
    'ngSanitize',
    'pasvaz.bindonce',
    'angular-growl',
    'LocalStorageModule',
  ]
)

cms.run ['$rootScope', '$location', '$state', '$window','$http','Session','User','localStorageService'
  ($rootScope, $location, $state, $window, $http,Session,User,localStorageService) ->


    $rootScope.startLoading = ->
      NProgress.start()
      $rootScope.loading = true

    $rootScope.stopLoading = ->
      $rootScope.loading = false
      NProgress.done()


    # this handles auth on stateChange
    # dependent on ui-routers

    # authenticator flag serves as
    # a flagger if on state change, the token is still valid
    $rootScope.authenticatorFlag = true

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
      # this will happen if there is already a cookie
      # and if the user just refreshes the page
      # thus clearing the rootScope.currentUser

      if $rootScope.authenticatorFlag && toState.data isnt undefined &&(!!toState.data.authenticated || !!toState.data.unauthenticated)
        event.preventDefault()

        $rootScope.authenticatorFlag = false
        authToken = localStorageService.get('authToken')
        $http.defaults.headers.common.Authorization = authToken

        if authToken isnt null
          Session.getCurrentUser().$promise
            .then (data) ->
              $rootScope.currentUser = new User(data)
              $rootScope.startLoading()
              if toState.data.authenticated
                $state.go(toState.name, toParams)
              else if toState.data.unauthenticated
                $state.go("cms.posts.index")

            .catch (err) ->
 
              unless err.message == "transition prevented"
                debugger
                $rootScope.authenticatorFlag = true
                localStorageService.remove('authToken')
                $state.go("login")
        else
          if toState.data.unauthenticated
            $state.go(toState.name, toParams)
          else
            $state.go("cms.login")



    # resets the authenticator flag
    # so that it will go authentication on every state change (if state is authenticable)
    $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
      $rootScope.authenticatorFlag = true
  ]
