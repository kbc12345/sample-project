json.collection @collection do |obj|
  json.partial! 'applicant', obj: obj
end

json.metadata do
  json.count @collection.total_count
  json.page current_page
end
