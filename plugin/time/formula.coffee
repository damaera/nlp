module.exports = [
  

  # day relative
  { prev: /^hari$/, next: /^ini$/, tag: 'day_relative', val: 0 }
  { prev: /^besok$/, next: /^lusa$/, tag: 'day_relative', val: 2 }
  { prev: /^kemarin$/, next: /^lusa$/, tag: 'day_relative', val: -2 }

  # setengah 5
  { prev: '/^(setengah|stgh)$', next: /^num$/, tag: 'half_time' }

  # jam 4
  { prev: /^time_mark$/, next: /^num$/, tag: 'time_XX' }
  { prev: /^time_mark$/, next: /^num$/, tag: 'time_XX' }

]