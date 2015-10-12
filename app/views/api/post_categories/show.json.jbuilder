json.post_categories do
  json.extract! @obj, *%i(
    name
    id
  )
end