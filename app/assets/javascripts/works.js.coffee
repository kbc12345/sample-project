$(document).on "click", '.filter-works', (event) ->
  event.preventDefault()
  $this = $(this)

  unless $this.hasClass("active")
    hideActive()
    changeActive($this)


$(document).on "click", '.project', (event) ->
  event.preventDefault()
  $('#works-nav').fadeOut(200)
  $('#works-items').fadeOut(200)
  $('#works-details').delay(300).fadeIn()

$(document).on "click", '.close-project-btn', (event) ->
  event.preventDefault()
  $('#works-details').fadeOut(200)
  $('#works-nav').delay(300).fadeIn()
  $('#works-items').delay(300).fadeIn()

hideActive = ->
  activeClass = $('.active')
  currentFilter = activeClass.data('filter')
  $('.'+currentFilter+'-row').fadeOut(200)

changeActive =(current) ->
  $('.active').removeClass("active")
  current.addClass("active")
  $('.'+current.data('filter')+'-row').delay(300).fadeIn()