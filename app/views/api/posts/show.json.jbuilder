json.post do
  json.extract! @obj, *%i(
    title
    status
    user_id
    posted_date
    id
    created_at
    content
    excerpt
    post_category_id
    tags
    slug
  )
end