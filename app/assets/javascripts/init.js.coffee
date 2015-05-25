$(document).ready ->

  # makes the landing text center
  if $("#landing-text").length > 0
    relativeHeight = $(window).height()/2
    #meaning mobile
    if relativeHeight <= 380
      heightOffset = 150
      playHeight = 210
    else if relativeHeight <= 240
      heightOffset = 80
      playHeight = 25
    else
      heightOffset = Math.floor(relativeHeight-130)
      playHeight =  Math.floor(relativeHeight-250)

    $("#landing-text").css("margin-top", heightOffset)
    $("#pull-btn-section").css("margin-top", playHeight)
    $("#dash").css("top", $(window).height()-65)

$(document).on "click", '.animate-anchor', (event) ->
  event.preventDefault()
  $('html, body').animate { scrollTop: $($.attr(this, 'href')).offset().top }, 500


$(document).on "click", '#btn-nav-toggle', (event) ->
  event.preventDefault()
  wrapper = $('#page-wrapper')
  body = $('body')

  if wrapper.hasClass("pushed")
    wrapper.removeClass("pushed")
    body.removeClass("disable-scroll")
  else
    body.addClass("disable-scroll")
    wrapper.addClass("pushed")