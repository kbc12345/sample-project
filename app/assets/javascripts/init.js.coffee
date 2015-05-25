$(document).ready ->

  # makes the landing text center
  if $("#landing-text").length > 0
    relativeHeight = $(window).height()/2
    #meaning mobile
    if relativeHeight <= 380
      heightOffset = 230
      playHeight = 310
    else
      heightOffset = 130
      playHeight = 250

    $("#landing-text").css("margin-top", Math.floor(relativeHeight-heightOffset))
    $("#pull-btn-section").css("margin-top", Math.floor(relativeHeight-playHeight))
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