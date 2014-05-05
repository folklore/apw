# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

p1 = Sheet.create(name: 'name1', title: 'title1', text: '**строка_string** \\\\строка_string\\\\ ((name1/name12/name121 строка_string))')
  p11 = Sheet.create(name: 'name11', title: 'title1.1', text: '**строка_string** \\\\строка_string\\\\ ((name1/name12/name121 строка_string))', p_id: p1.id)
  p12 = Sheet.create(name: 'name12', title: 'title1.2', text: '**строка_string** \\\\строка_string\\\\ ((name1/name12/name121 строка_string))', p_id: p1.id)
    p121 = Sheet.create(name: 'name121', title: 'title1.2.1', text: '**строка_string** \\\\строка_string\\\\ ((name1/name12/name121 строка_string))', p_id: p12.id)
    p122 = Sheet.create(name: 'name122', title: 'title1.2.2', text: '**строка_string** \\\\строка_string\\\\ ((name1/name12/name121 строка_string))', p_id: p12.id)
  p13 = Sheet.create(name: 'name13', title: 'title1.3', text: '**строка_string** \\\\строка_string\\\\ ((name1/name12/name121 строка_string))', p_id: p1.id)

p2 = Sheet.create(name: 'name2', title: 'title2', text: '**строка_string** \\\\строка_string\\\\ ((name1/name12/name121 строка_string))')
  p21 = Sheet.create(name: 'name21', title: 'title2.1', text: '**строка_string** \\\\строка_string\\\\ ((name1/name12/name121 строка_string))', p_id: p2.id)
  p22 = Sheet.create(name: 'name22', title: 'title2.2', text: '**строка_string** \\\\строка_string\\\\ ((name1/name12/name121 строка_string))', p_id: p2.id)
    p221 = Sheet.create(name: 'name221', title: 'title2.2.1', text: '**строка_string** \\\\строка_string\\\\ ((name1/name12/name121 строка_string))', p_id: p22.id)
      p2211 = Sheet.create(name: 'name2211', title: 'title2.2.1.1', text: '**строка_string** \\\\строка_string\\\\ ((name1/name12/name121 строка_string))', p_id: p221.id)
      p2212 = Sheet.create(name: 'name2212', title: 'title2.2.1.2', text: '**строка_string** \\\\строка_string\\\\ ((name1/name12/name121 строка_string))', p_id: p221.id)