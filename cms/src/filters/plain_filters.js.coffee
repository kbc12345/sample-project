@findByName =(obj,collection) ->
  chosenObj = null
  for item in collection
    if item.name == obj
      chosenObj = item
      break
  chosenObj

@findById =(obj,collection) ->
  chosenObj = null
  for item in collection
    if item.id == obj
      chosenObj = item
      break
  chosenObj