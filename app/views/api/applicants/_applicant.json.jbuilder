json.extract! obj, *%i(
  name
  email
  created_at
  id
)
json.resume_url obj.resume.url