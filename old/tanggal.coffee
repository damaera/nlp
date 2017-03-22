# hari ini
# kemarin
# besok
# jumat
# kamis depan
# rabu lalu
regexHari = /(ahad|minggu|senin|selasa|rabu|kamis|jumat|sabtu) ?(besok|nanti|depan|kemarin|lalu)?|(kemarin lusa|besok lusa|kemarin|besok|lusa|hari ini)/

# minggu depan
# tahun lalu
regexHariRelatif = /(minggu|bulan|tahun) (depan|besok|lalu|kemarin)/

sekarang = new Date()

# hari = 0 - 6
# tanggal = 1 - 31
hariIni = sekarang.getDay()
tanggalIni = sekarang.getDate()
bulanIni = sekarang.getMonth()
tahunIni = sekarang.getFullYear()

hariMap =
  'ahad': 0
  'minggu': 0
  'senin': 1
  'selasa': 2
  'rabu': 3
  'kamis': 4
  'jumat': 5
  'sabtu': 6
  'hari ini': hariIni
  'kemarin': sekarang.getDay()-1
  'besok': sekarang.getDay()+1
  'kemarin lusa': sekarang.getDay()-2
  'besok lusa': sekarang.getDay()+2
  'lusa': sekarang.getDay()+2

result = []

module.exports = (kalimat) ->


  kalimatHari = kalimat.match new RegExp regexHari.source, 'g'
  future = true

  for kal in kalimatHari

    year = tahunIni
    month = bulanIni
    day = hariIni
    date = tanggalIni

    [allText, hari, ketNanti, hariRelatif] = regexHari.exec kal

    for k, v of hariMap
      if k is hari
        dayOfWeek = v
      else if k is hariRelatif
        dayOfWeek = v

    rentangHari = dayOfWeek - hariIni
    if rentangHari < 1
      rentangHari += 7

    date += rentangHari

    if ketNanti
      if /(kemarin|lalu)/.test
        if dayOfWeek > 

    console.log date







