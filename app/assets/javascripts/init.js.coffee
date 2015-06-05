$(document).on 'ready page:load', ->

  #fastlick
  FastClick.attach(document.body)

  # makes the landing text center
  if $("#landing-text").length > 0
    relativeHeight = $(window).height()/2
    
    #meaning mobile
    if relativeHeight <= 280
      textOffset = 140
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
    dashHeight = $('#customers').offset().top-$('#btn-play').offset().top
    $('#dash').css("height", dashHeight-60)

$(document).on 'page:fetch', ->
  NProgress.start()
  return
$(document).on 'page:change', ->
  NProgress.done()
  return
$(document).on 'page:restore', ->
  NProgress.remove()
  return


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


$(document).on "click", '.btn-submit', (event) ->
  event.preventDefault()
  if isFormValid()
    $('#new_message').submit()
    $('#contact-form').fadeOut(200)
    $('#thank-you').delay(300).fadeIn()

$(document).on "click", '.btn-apply', (event) ->
  event.preventDefault()
  modal = $('.modal')
  body = $('body')

  if modal.hasClass("open")
    modal.removeClass("open")
    body.removeClass("locked")
  else
    modal.addClass("open")
    body.addClass("locked")

$(document).on "change", '#applicant_resume', (event) ->
  event.preventDefault()
  $('.btn-cv').html($('#applicant_resume')[0].files[0].name)


$(document).on "click", '.btn-submit-applicant', (event) ->
  event.preventDefault()
  if isFormValid()
    $('.btn-submit-applicant').html("Uploading..").addClass("disabled")
    $('#new_applicant').submit()
    $('.form-control').prop("disabled", true)



isEmail =(email)->
  re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
  re.test(email);

isFormValid = ->
  requiredError = false
  emailError = false
  $('.required').each (index, element) =>

    if $(element).val().trim() == "" 
      requiredError = true 
      $(element).addClass("error")
    else if $(element).hasClass("email") && !isEmail(element.value)
      emailError = true
      $(element).addClass("error")
    else
      $(element).removeClass("error")

  if requiredError
    $.growl.error({ title: "", message: "Marked Fields are required" })
    return false
  else if emailError
    $.growl.error({ title: "", message: "Marked Field must be a valid Email" })
    return false
  else
    return true
