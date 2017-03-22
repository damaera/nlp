_ = require 'lodash'

kalimat = 'bangunkan saya besok jam setengah 4'

regexTanggal = /(tanggal)? ?([0-9]+( ()))/

regexHari = /(ahad|minggu|senin|selasa|rabu|kamis|jumat|sabtu|kemarin lusa|besok lusa|kemarin|besok|lusa|hari ini)/
regexHariRelatif = /(lalu|mendatang|depan|yang akan datang|kemarin|besok|lagi)/

regexUkuranWaktu = /(detik|menit|jam|hari|minggu|bulan|tahun)/

regexJam = /(jam|pukul) ?(([0-9]+)[\:|\.| ]?([0-9]+)? ?(am|pm|pagi|siang|sore|malam)?|(setengah|set)? ?([0-9]+|satu|dua|tiga|empat|lima|enam|tujuh|delapan|sembilan|sepuluh|sebelas|dua belas) ?(lebih|kurang)? ?(seperempat|([0-9]+) ?(menit|detik)? ?(am|pm|pagi|siang|sore|malam)?))/

regexBagianHari = /(pagi|siang|sore|malam)/

allRegex = new RegExp "#{regexBagianHari.source}? ?#{regexHari.source}? #{regexBagianHari.source}? ?(#{regexHari.source} #{regexHariRelatif.source})? ?#{regexJam.source}? ?#{regexBagianHari.source}?", 'g'

kalimatWaktu = kalimat.match allRegex

result = []

for kal in kalimatWaktu

  # hari dalam minggu
  hariDalamMinggu = null

  # default, waktu mendatang
  # misal. hari ini kamis, senin jam 3 artinya senin depan
  waktuMendatang = true

  isHari = regexHari.test kal
  isJam = regexJam.test kal

  # jika kalimat terdapat hari
  if isHari
    hasilRegexHari = regexHari.exec kal
    [textAll, hari] = hasilRegexHari
    { index } = hasilRegexHari

    sekarang = new Date

    hariMap =
      'ahad': 0
      'minggu': 0
      'senin': 1
      'selasa': 2
      'rabu': 3
      'kamis': 4
      'jumat': 5
      'sabtu': 6
      'hari ini': sekarang.getDay()
      'kemarin': sekarang.getDay()-1
      'besok': sekarang.getDay()+1
      'kemarin lusa': sekarang.getDay()-2
      'besok lusa': sekarang.getDay()+2
      'lusa': sekarang.getDay()+2

    hariDalamMinggu = null
    for k, v of hariMap
      if k is hari
        hariDalamMinggu = v
        if hari is 'kemarin' or hari is 'kemarin lusa'
          waktuMendatang = false

    # mencari kata sesudah hari, untuk menentukan waktu lalu atau mendatang
    # misal senin lalu / senin mendatang
    hariRelatif = kal[index+hari.length+1..]
    if regexHariRelatif.test hariRelatif
      if /^(lalu|kemarin)/.test hariRelatif
        waktuMendatang = false
      # if not isJam
      #   if isJam
      

    if hariDalamMinggu > 6
      hariDalamMinggu = hariDalamMinggu % 7  
    else if hariDalamMinggu < 0
      hariDalamMinggu = hariDalamMinggu + 7

  # jika kalimat terdapat jam
  if isJam
    jam = null
    menit = null
    [textAll, p, textJamAngka, jamAngka, menitAngka, ampmAngka, setengah, jamKata, kurangLebih  ] = regexJam.exec kal
    console.log regexJam.exec kal
    if jamAngka
      jam = jamAngka*1
      menit = 0
      if menitAngka
        menit = menitAngka
      if ampmAngka
        if ampmAngka is 'pm' and jam < 12
          jam += 12
        else if ampmAngka is 'siang' and jam >= 0 and jam <= 3
          jam += 12
        else if ampmAngka is 'malam' and jam >= 7
          jam += 12
    else
      jam = jamKata*1
      console.log jamKata
      if setengah
        jam = jam - 1
        menit = 30

  result.push
    input: _.trim kal
    future: waktuMendatang
    hour: jam
    minute: menit
    dayOfWeek: hariDalamMinggu

console.log result