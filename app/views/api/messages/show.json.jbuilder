json.messages do

  json.extract! @obj, *%i(
    sender
    email
    message
  )
end