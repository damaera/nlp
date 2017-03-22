getWords = require './util/getWords'

parseNumber = require './plugin/number/parse'
parseTime = require './plugin/time/parse'

kalimat = '1.5k'

words = getWords kalimat
words2 = parseNumber words
words3 = parseTime words2
console.log words3