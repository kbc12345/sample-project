$(document).ready ->

  # makes the landing text center
  if $("#landing-text").length > 0
    relativeHeight = $(window).height()/2
    $("#landing-text").css("margin-top", Math.floor(relativeHeight-130))
    $("#pull-btn-section").css("margin-top", Math.floor(relativeHeight-250))
    $("#dash").css("margin-top", Math.floor(relativeHeight-275))

$(document).on "click", '.animate-anchor', (event) ->
  event.preventDefault()
  $('html, body').animate { scrollTop: $($.attr(this, 'href')).offset().top }, 500


$(document).on "click", '#btn-nav-toggle', (event) ->
  event.preventDefault()
  mobile_nav = $('.mobile-nav')
  wrapper = $('#page-wrapper')
  body = $('body')

  if mobile_nav.hasClass("block")
    mobile_nav.removeClass("block").addClass("hidden")
    wrapper.removeClass("pushed")
    body.removeClass("disable-scroll")
  else
    mobile_nav.removeClass("hidden").addClass("block")
    body.addClass("disable-scroll")
    wrapper.addClass("pushed")