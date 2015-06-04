angular.module('cms').directive 'billingForm', ->
  restrict: 'A'
  replace: true
  templateUrl: 'billing/form.html'

angular.module('cms').directive 'billingTerms', ->
  restrict: 'A'
  replace: true
  templateUrl: 'billing/terms.html'