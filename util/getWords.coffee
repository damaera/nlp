module.exports = (str) ->
  # arr = ((str.split /(\d+)/g).join ' ').match /(\w+)/g
  arr = str.split ' '
  newArr = []

  # console.log (str.split /(\d+)/g)
  for x in arr

    # alphanumeric 26K, 11am, 2K16
    if /^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9.,]+)$/.test x
      if /[\.,]/.test x
        x2 = x.split /([a-zA-Z]+)/g
      else
        x2 = x.split /(\d+)/g

      replacing = true
      if /(\d+)[.|,](\d+)([a-zA-Z]+)/.test x
        replacing = false

      for y in x2
        if y.length > 0
          if replacing
            y = y.replace '.', ''
          newArr.push { text: y.toLowerCase(), tag: [y]}
    else
      x = x.replace '.', ''
      newArr.push { text: x.toLowerCase(), tag: [x] }
  newArr