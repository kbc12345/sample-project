json.collection @collection do |obj|
  json.partial! 'categories', obj: obj
end
