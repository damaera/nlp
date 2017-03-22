akarata = require 'akarata'

testWord = 'cuaca besok'

result = []

for word in testWord.split ' '
  result.push akarata.stem word

console.log result


  