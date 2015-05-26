$(document).ready ->

  # makes the landing text center
  if $("#landing-text").length > 0
    relativeHeight = $(window).height()/2
    #meaning mobile
    if relativeHeight <= 280
      textOffset = 160
      playOffset = 170
    else if relativeHeight <= 380
      textOffset = 220
      playOffset = 160
    else if relativeHeight <= 240
      heightOffset = 80
      playOffset = 25
    else
      textOffset = 130
      playOffset =  250

    $("#landing-text").css("margin-top", relativeHeight-textOffset)
    $("#pull-btn-section").css("margin-top", relativeHeight-playOffset)
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