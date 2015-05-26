'use strict'
angular.module('cms').factory 'SweetAlert', [
  '$timeout'
  '$window'
  ($timeout, $window) ->
    swal = $window.swal
    #public methods
    self = 
      swal: (arg1, arg2, arg3) ->
        $timeout (->
          if typeof arg2 == 'function'
            swal arg1, ((isConfirm) ->
              $timeout ->
                arg2 isConfirm
                return
              return
            ), arg3
          else
            swal arg1, arg2, arg3
          return
        ), 200
        return
      adv: (object) ->
        $timeout (->
          swal object
          return
        ), 200
        return
      timed: (title, message, type, time) ->
        $timeout (->
          swal
            title: title
            text: message
            type: type
            timer: time
          return
        ), 200
        return
      success: (title, message) ->
        $timeout (->
          swal title, message, 'success'
          return
        ), 200
        return
      error: (title, message) ->
        $timeout (->
          swal title, message, 'error'
          return
        ), 200
        return
      warning: (title, message) ->
        $timeout (->
          swal title, message, 'warning'
          return
        ), 200
        return
      info: (title, message) ->
        $timeout (->
          swal title, message, 'info'
          return
        ), 200
        return
    self
]
