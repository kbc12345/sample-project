$(document).on 'ready page:load', ->

  #fastlick
  FastClick.attach(document.body)

  windowHeight = window.innerHeight

  # makes the landing text center
  if $("#landing-text").length > 0 
    heightOffset = windowHeight-$('#landing-text').height()
    # Special case when it is a small mobile phone ex. iphone 4,5
    heightOffset = 130 if heightOffset < 80
    $('#landing-text').css("margin-top", heightOffset)
    $("#dash").css("top", windowHeight-65)
    dashHeight = $('#customers').offset().top-$('#btn-play').offset().top
    $('#dash').css("height", dashHeight-60)


  if $("#about-landing-text").length > 0
    windowHeight = windowHeight/2
    heightOffset = windowHeight-$('#about-landing-text').height()+150
    # Special case when it is a small mobile phone ex. iphone 4,5
    heightOffset = 120 if heightOffset < 160
    $('#about-landing-text').css("margin-top", heightOffset)

  if $('#works-laptop').length > 0
    windowHeight = windowHeight/2
    heightOffset = windowHeight-$('#work-landing-text').height()+100
    imageOffset =  window.innerHeight-600
    $('#works-laptop').css("top", imageOffset)
    $('#work-landing-text').css("margin-top", heightOffset)


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
  sidebar = $('#sidebar')

  if wrapper.hasClass("pushed")
    wrapper.removeClass("pushed")
    body.removeClass("disable-scroll")
    sidebar.removeClass("pushed")
  else
    body.addClass("disable-scroll")
    wrapper.addClass("pushed")
    sidebar.addClass("pushed")


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
