angular.module('cms').directive 'cmsHeader', ->
  restrict: 'A'
  replace: true
  templateUrl: 'layouts/partials/header.html'