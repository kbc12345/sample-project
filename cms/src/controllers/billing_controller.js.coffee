angular.module('cms').controller 'BillingController',
['$scope','$rootScope','Applicant','$state','$filter','growl','Billing','$sce'
($scope,$rootScope,Applicant,$state,$filter,growl,Billing,$sce) ->

  $rootScope.bodyClass = "billing"
  $scope.terms = 
    bol: false
    openModal: false
    content: ""

  $rootScope.stopLoading()

  Billing.getTerms().$promise
    .then (data) ->
      $scope.terms.content = $sce.trustAsHtml(data.terms)

  $scope.submit =(form) ->
    form.$submitted = true
    if form.$valid

      unless isEmail $scope.billing.email
        form.email.$error.required = true
        growl.error("Marked Field must be a valid Email ")
        return false

      tempObj = angular.copy $scope.billing
      growl.success(MESSAGE.SAVE_SUCCESS)
      Billing.save(billing: tempObj).$promise
      $scope.billing = null
      form.$submitted = false
    else
      growl.error(MESSAGE.FORM_ERROR)

  isEmail =(email)->
    re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    re.test(email);

]
