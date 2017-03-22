# jam 2
# jam 14.00
# jam 15:12
# 15:12 am
# pukul 2
# jam 2 siang
regexJam = /(jam|pukul)? ?(setengah|set)? ?([0-9]+[\:|\.| ][0-9]+|[0-9]+|satu|dua ?belas|dua|tiga|empat|lima|enam|tujuh|delapan|sembilan|sepuluh|sebelas) ?(lebih|kurang)? ?(seperempat|[0-9]+)? ?(menit)? ?(am|pm|pagi|siang|sore|malam)?/

# nanti siang
# nanti malam jam 2
regexJamSpesial = /(nanti (siang|malam))/

result = []

module.exports = (kalimat) ->

  kalimatWaktu = kalimat.match new RegExp regexJam.source, 'g'
  kalimatWaktuSpesial = kalimat.match new RegExp regexJam.source, 'g'

  if kalimatWaktu

    # mencegah hanya 1 saja
    # "satu", "dua" dst dianggap true oleh regex, padahal cuma angka biasa
    kelengkapan = 0

    for kal in kalimatWaktu
      [allText, p, setengah, jam, kurangLebih, kurangLebihAngka, menit, ampm] = regexJam.exec kal

      if p then kelengkapan+=1
      if setengah then kelengkapan+=1
      if jam then kelengkapan+=1
      if kurangLebih then kelengkapan+=1
      if kurangLebihAngka then kelengkapan+=1
      if ampm then kelengkapan+=1

      if jam
        if /[0-9]+[\:|\.| ][0-9]+/.test jam
          splitter = (kal.match /[0-9]+([\:|\.| ])[0-9]+/)[1]
          [jam, menit] = jam.split splitter
          kelengkapan+=1
          if jam > 24 or menit > 60
            continue
        else
          switch jam
            when 'satu' then jam = 1
            when 'dua' then jam = 2
            when 'tiga' then jam = 3
            when 'empat' then jam = 4
            when 'lima' then jam = 5
            when 'enam' then jam = 6
            when 'tujuh' then jam = 7
            when 'delapan' then jam = 8
            when 'sembilan' then jam = 9
            when 'sepuluh' then jam = 10
            when 'sebelas' then jam = 11
            when 'dua belas' then jam = 12
            when 'duabelas' then jam = 12
      
      if not menit
        menit = 0

      jam*=1
      menit*=1

      if ampm and jam < 12
        if ampm is 'pm'
          jam += 12
        else if ampm is 'siang' and jam >= 0 and jam <= 3
          jam += 12
        else if ampm is 'sore' and jam >= 3 and jam <= 7
          jam += 12
        else if ampm is 'malam' and jam >= 7
          jam += 12

      if setengah
        jam -= 1
        menit = 30

      if kurangLebihAngka is 'seperempat'
        kurangLebihAngka = 15
      if kurangLebihAngka
        if not menit
          menit = kurangLebihAngka
      if kurangLebih and kurangLebihAngka
        if kurangLebih is 'kurang'
          jam -= 1
          menit = 60 - kurangLebihAngka
        else
          menit = kurangLebihAngka


      if not (kelengkapan is 1 and jam)
        result.push
          input: kal.trim()
          hour: jam
          minute: menit

    # special case
  else
    console.log ''

  result