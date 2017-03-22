tags = require './tag'

getBigram = require '../../util/getBigram'

formula = require './formula'

tagging = (arr) ->

  bigram = getBigram arr

  for f in formula
    for bi, i in bigram
      for tag0 in bi[0].tag
        for tag1 in bi[1].tag
          if !!(tag0.match f.prev) and !!(tag1.match f.next)
            bi.tag = [f.tag]
            bi.val = f.val
            arr[i] = bi
            arr.splice i+1, 1


            return tagging arr
  return arr

module.exports = (arr) ->

  # bigram = getBigram arr
  newArr = []

  for kata in arr
    for angka in tags
      if angka.regex?.test kata.text
        console.log ''
      else if kata.text is angka.text
        kata.tag.push angka.tag
    newArr.push kata

  newArr2 = tagging newArr

  # console.log newArr
  newArr2
