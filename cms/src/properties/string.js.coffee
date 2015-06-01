String::formatDate = ->
  if !!this.toString() then moment(new Date(this.toString())).format("MMM DD, YYYY") else ""