module.exports = (arr, count) ->
  newArr1 = []
  arrLn = arr.length
  for x,y in arr
    if y < (arrLn - count + 1)
      newArr1[y] = []
      for i in [0..(count-1)]
        newArr1[y][i] = arr[y+i]
  newArr1