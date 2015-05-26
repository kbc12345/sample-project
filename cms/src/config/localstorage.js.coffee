angular.module('cms').config [
  'localStorageServiceProvider'
  (localStorageServiceProvider) ->
    localStorageServiceProvider.setPrefix('cms')
    .setStorageType('localStorage')
    .setNotify(true, true)

  ]
