# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Place.create(
    name: 'Лаплас',
    place_type: 'restaurant',
    logo: 'laplas_logo.png',
    img: 'laplas_img.jpg',
    desc: 'Если Вы решили провести незабываемый романтический вечер или весело отдохнуть компанией – смело направляйтесь в ресторан "Ла Плас"! Здесь Вас приятно удивят великолепные блюда, их оригинальное оформление и подача.',
    hours: {
        mon: %w(12:00 21:00),
        tue: %w(12:00 21:00),
        wed: %w(12:00 21:00),
        thu: %w(12:00 21:00),
        fri: %w(12:00 21:00),
        sat: %w(12:00 21:00),
        sun: %w(12:00 21:00)
    },
    city: 'Калининград',
    street: 'пл. Победы',
    building: '1',
    flags: %w(can_book has_parking smoke_room)
)

Place.create(
   name: 'Британника',
   place_type: 'restaurant',
   logo: '1_logo.png',
   img: '1.png',
   desc: 'Около 10 лет назад в самом центре Калининграда появился уютный ресторан, рассчитанный на самую широкую аудиторию и готовый вместить в себя до шестидесяти человек. Это заведение носит гордое название – «Британника».',
   hours: {
       mon: %w(12:00 21:00),
       tue: %w(12:00 21:00),
       wed: %w(12:00 21:00),
       thu: %w(12:00 21:00),
       fri: %w(12:00 21:00),
       sat: %w(12:00 21:00),
       sun: %w(12:00 21:00)
   },
   city: 'Калининград',
   street: 'пл. Победы',
   building: '1',
   flags: %w(can_book has_parking smoke_room)
)