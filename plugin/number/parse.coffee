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
            res = {}
            res.text = bi
            res.tag = [f.tag]
            if f.calc is '*'
              res.val = bi[0].val * bi[1].val
            else if f.calc is '+'
              res.val = bi[0].val + bi[1].val

            arr[i] = res
            arr.splice i+1, 1
            return tagging arr
  return arr

module.exports = (arr) ->

  newArr = []

  for kata in arr
    for angka in tags
      if angka.regex?.test kata.text
        
        [text, int, flt] = angka.regex.exec kata.text
        kata.tag = []

        if flt
          val = "#{int}.#{flt}"*1
          kata.tag.push 'num_float'
        else
          val = int*1
          if val < 10
            kata.tag.push 'num_X'
          else if val < 100
            kata.tag.push 'num_XX'
          else if val < 1000
            kata.tag.push 'num_XXX'
          else if val < 1000000
            kata.tag.push 'num_XXXX'
          else if val < 1000000000
            kata.tag.push 'num_XXXXX'
          else
            kata.tag.push 'num_XXXXXX'

        kata.val = val

      else if kata.text is angka.text
        kata.val = angka.val
        kata.tag = [angka.tag]
        
    newArr.push kata


  newArr2 = tagging newArr

  result = []

  for arr in newArr2
    if arr.tag[0]?.match /^num_/
      arr.tag.push 'num'

    result.push arr
  result
