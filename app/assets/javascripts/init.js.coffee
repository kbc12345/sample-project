$(document).ready ->

  # makes the landing text center
  if $("#landing-text").length > 0
    $("#landing-text").css("margin-top", Math.floor(($(window).height()/2)-130))