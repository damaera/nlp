module.exports = [
  # nol
  { text: 'nol', val: 0, tag: 'num_0' }
  { text: 'kosong', val: 0, tag: 'num_0' }
  
  # satuan
  { text: 'satu', val: 1, tag: 'num_X' }
  { text: 'dua', val: 2, tag: 'num_X' }
  { text: 'tiga', val: 3, tag: 'num_X' }
  { text: 'empat', val: 4, tag: 'num_X' }
  { text: 'lima', val: 5, tag: 'num_X' }
  { text: 'enam', val: 6, tag: 'num_X' }
  { text: 'tujuh', val: 7, tag: 'num_X' }
  { text: 'delapan', val: 8, tag: 'num_X' }
  { text: 'sembilan', val: 9, tag: 'num_X' }

  # belasan
  { text: 'sebelas', val: 11, tag: 'num_XX' }
  # { text: 'dua belas', val: 12, tag: 'num_XX' }
  # { text: 'tiga belas', val: 13, tag: 'num_XX' }
  # { text: 'empat belas', val: 14, tag: 'num_XX' }
  # { text: 'lima belas', val: 15, tag: 'num_XX' }
  # { text: 'enam belas', val: 16, tag: 'num_XX' }
  # { text: 'tujuh belas', val: 17, tag: 'num_XX' }
  # { text: 'delapan belas', val: 18, tag: 'num_XX' }
  # { text: 'sembilan belas', val: 19, tag: 'num_XX' }

  # exceptional
  { text: 'sepuluh', val: 10, tag: 'num_XX' }
  { text: 'seratus', val: 100, tag: 'num_X00' }
  { text: 'seribu', val: 1000, tag: 'num_X000' }
  { text: 'sejuta', val: 1000000, tag: 'num_X0000' }
  { text: 'semiliar', val: 1000000000, tag: 'num_X00000' }
  { text: 'setriliun', val: 1000000000000, tag: 'num_X000000' }

  # satuan
  { text: 'belas', val: 10, tag: 'n_0' }

  { text: 'puluh', val: 10, tag: 'n_1' }
  { text: 'ratus', val: 100, tag: 'n_2' }
  { text: 'ribu', val: 1000, tag: 'n_3' }
  { text: 'juta', val: 1000000, tag: 'n_6' }

  
  { text: 'miliar', val: 1000000000, tag: 'n_9' }
  { text: 'triliun', val: 1000000000000, tag: 'n_12' }

  { text: 'k', val: 1000, tag: 'n_3' }
  { text: 'rb', val: 1000, tag: 'n_3' }
  { text: 'm', val: 1000000, tag: 'n_6' }
  { text: 'jt', val: 1000000, tag: 'n_6' }

  { regex: /^([0-9]+)[.|,]?([0-9]+)?$/, tag: 'num_rgx'}

]