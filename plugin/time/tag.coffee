module.exports = [

  { text: 'detik', val: 'sec', tag: 'unit_time' }
  { text: 'menit', val: 'min', tag: 'unit_time' }
  { text: 'jam', val: 'hr', tag: 'unit_time' }
  { text: 'hari', val: 'day', tag: 'unit_time' }
  { text: 'bulan', val: 'mth', tag: 'unit_time' }
  { text: 'tahun', val: 'yr', tag: 'unit_time' }

  { regex: /([0-1]?[0-9]|2[0-3])[.|:]([0-5][0-9])/, tag: 'hh:mm' }
  { regex: /([0-1]?[0-9]|2[0-3])[.|:]([0-5][0-9])[.|:]([0-5][0-9])/, tag: 'hh:mm:ss' }

  { text: 'jam', tag: 'time_mark' }
  { text: 'pukul', tag: 'time_mark' }

  { text: 'tanggal', tag: 'date_mark' }

  { text: 'besok', val: 1, tag: 'day_relative' }
  { text: 'kemarin', val: -1, tag: 'day_relative' }

  { text: 'malam', val: 19, tag: 'part_of_day' }
  { text: 'pagi', val: 6, tag: 'part_of_day' }
  { text: 'siang', val: 11, tag: 'part_of_day' }
  { text: 'sore', val: 3, tag: 'part_of_day' }

  { text: 'am', val: 0, tag: 'ampm' }
  { text: 'pm', val: 12, tag: 'ampm' }

  { text: 'ahad', val: 0, tag: 'name_day' }
  { text: 'minggu', val: 0, tag: 'name_day' }
  { text: 'senin', val: 1, tag: 'name_day' }
  { text: 'selasa', val: 2, tag: 'name_day' }
  { text: 'rabu', val: 3, tag: 'name_day' }
  { text: 'kamis', val: 4, tag: 'name_day' }
  { text: 'jumat', val: 5, tag: 'name_day' }
  { text: 'sabtu', val: 6, tag: 'name_day' }


]  