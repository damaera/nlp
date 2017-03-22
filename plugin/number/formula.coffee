module.exports = [
  # belasan
  { prev: /^num_X$/, next: /^n_0$/, tag: 'num_XX', calc: '+' }
  
  # puluhan
  { prev: /^num_X$/, next: /^n_1$/, tag: 'num_X0', calc: '*' }
  { prev: /^num_X0$/, next: /^num_X$/, tag: 'num_XX', calc: '+' }

  # ratusan
  { prev: /^num_X$/, next: /^n_2$/, tag: 'num_X00', calc: '*' }
  { prev: /^num_[1|X]00$/, next: /^num_X[1|0|X]{0,1}$/, tag: 'num_XXX', calc: '+' }

  # ribuan, puluhan ribu, ratusan ribu
  { prev: /^num_X[1|0|X]{0,2}$/, next: /^n_3$/, tag: 'num_X000', calc: '*' }
  { prev: /^num_X000$/, next: /^num_X[1|0|X]{0,2}$/, tag: 'num_XXXX', calc: '+' }

  # jutaan, puluhan juta, ratusan juta
  { prev: /^num_X[1|0|X]{0,2}$/, next: /^n_6$/, tag: 'num_X0000', calc: '*' }
  { prev: /^num_X0000$/, next: /^num_X[1|0|X]{0,4}$/, tag: 'num_XXXXX', calc: '+' }

  # miliaran, puluhan miliar, ratusan miliar
  { prev: /^num_X[1|0|X]{0,2}$/, next: /^n_9$/, tag: 'num_X00000', calc: '*' }
  { prev: /^num_X00000$/, next: /^num_X[1|0|X]{0,5}$/, tag: 'num_XXXXXX', calc: '+' }

  # triliunan, puluhan triliun, ratusan triliun
  { prev: /^num_X[1|0|X]{0,2}$/, next: /^n_12$/, tag: 'num_X000000', calc: '*' }
  { prev: /^num_X000000$/, next: /^num_X[1|0|X]{0,5}$/, tag: 'num_XXXXXXX', calc: '+' }

  # 1,5 ribu
  { prev: /^num_float$/, next: /^n_3$/, tag: 'num_XXXX', calc: '*' }
  { prev: /^num_float$/, next: /^n_6$/, tag: 'num_XXXXX', calc: '*' }
  { prev: /^num_float$/, next: /^n_9$/, tag: 'num_XXXXXX', calc: '*' }
  { prev: /^num_float$/, next: /^n_12$/, tag: 'num_XXXXXXX', calc: '*' }
]