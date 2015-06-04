angular.module('cms').controller 'TermsController',
['$scope','$rootScope','Applicant','$state','$filter','growl','Terms','$sce'
($scope,$rootScope,Applicant,$state,$filter,growl,Terms,$sce) ->


  $scope.terms = 
    content: ""
  $scope.getObj = ->
    Terms.getTerms().$promise
      .then (data) ->
        $scope.terms.content = data.terms
        $rootScope.stopLoading()

  $scope.save = ->
    growl.success(MESSAGE.UPDATE_SUCCESS)
    Terms.update({id: 1},content: $scope.terms.content).$promise

]
