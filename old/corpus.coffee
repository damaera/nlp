extractTime = (kalimat) ->
  # jam 12.30
  # pukul 23:35
  # jam 9
  regexJam1 = /(jam|pukul)? ?([01]?[0-9]|2[0-4])[\.:]?([0-5][0-9])?[\.:]?([0-5][0-9])?/
  
  # 4 sore
  # 4 pagi
  # jam 5.45 pm
  # jam 7 malam
  regexJam2 = new RegExp "#{regexJam1.source} ?(am|pm|pagi|siang|malam|sore)"

  # jam 7 malam
  if regexJam2.test kalimat
    [kalimatJam] = kalimat.match regexJam2

    [allText, p, jam, menit, detik, ket] = regexJam2.exec kalimatJam

    jam *= 1
    if menit then menit *= 1 else menit = 0
    if detik then detik *= 1 else detik = 0

    if ket is 'pm' and jam < 12
      jam += 12
    else if ket is 'malam' and 6 <= jam < 12
      jam += 12
    else if ket is 'sore' and 2 <= jam < 8
      jam += 12

    time = new Date

    kalimat2 = kalimat.replace allText, "(time:#{time.setHours jam, menit, detik, 0})"
    extractTime kalimat2

  # jam 7.35
  else if regexJam1.test kalimat
    [kalimatJam] = kalimat.match regexJam1
    [allText, p, jam, menit, detik] = regexJam1.exec kalimatJam
    if allText is jam
      kalimat
    else
      jam *= 1
      if menit then menit *= 1 else menit = 0
      if detik then detik *= 1 else detik = 0
      time = new Date
      kalimat2 = kalimat.replace allText, "(time:#{time.setHours jam, menit, detik, 0})"
      extractTime kalimat2

  else
    kalimat

  # 10 menit lagi
  # 2 jam lalu

  # dalam 5 jam
  # dalam 2 hari

  # selasa jam 2
  # senin pukul 1.23
  # senin lalu jam 7 sore

  # rabu minggu depan
  # tanggal 20 bulan depan
  # bulan kemarin

console.log extractTime 'sekarang jam 7:23 malam dan jam 7 siang'