# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Course.delete_all
course_solo = Course.create({title: "Solo Course", description: "Our SOLO course is aimed at singers of all ages (18 plus). This could be young professionals on the threshold of a career, students at music colleges, amateurs of 'semi-pro' standard and singers with a little less experience, but a desire to sing really well."})
course_choral = Course.create({title: "Choral Course", description: "Our CHORAL course is open to all. We offer a range of choirs and vocal groups, covering a varied repertoire, catering, we hope, to individual tastes. Crucially, all our choral classes culminate in performances, be it lunctime concerts, or larger choral works with soloists and orchestra."})
course_cross = Course.create({title: "CROSSOVER Course", description: "The CROSSOVER COURSE has become increasingly popular in recent years, offers studetns the chance to 'pick and choose' from the SOLO or CHORAL courses. We feel this gives people a chance to really tailor their week with us, according to their preferences."})
course_piano = Course.create({title: "Piano Accompanist Course", description: "This is a great course for established duos, or for pianists looking to progress. This course is very much tailored to individual needs: you may be following a particular singer throughout their week, or you may be partnered with different singers, according to your preference and areas of interest. The aim is to produce and individual learning and performance opportunities with some of the best accompanist tutors."})
course_other = Course.create({title: "Other Course", description: "New in 2016, we have space for up to six students to take choral conducting classes with Gregory Rose. Students will need to be enrolled as either a choral or a crossover singing student, and alongside singing classes, they will work with Gregory on stick technique, observing and conducting."})
course_dropin = Course.create({title: "Drop-In Course", description: "Open to all students, by signing up in the onsite AIMS Office."})

Klass.delete_all
course_solo.klasses.create({title: "Vocal Technique", description: "Offered to all solo singers, this covers two sessions in the week, with the same tutor. Classes will focus on the technical aspects of singing and breathing. Bring any music that you are working on.", number_of_sessions: 2})
course_solo.klasses.create({title: "Opera Arias", description: "Three arias from opera. They can be from any period. Please include your titles when you book. This helps us to match you up with tutors.", number_of_sessions: 3})
course_solo.klasses.create({title: "Oratorio Arias", description: "Three arias from Oratorio. Again, we ask that you submit your choices when you book.", number_of_sessions: 3})

course_choral.klasses.create({title: "Madrigals", description: "This course for mixed voices will study a selection of English madrigals from the Oxford Book of English Madrigals.", repertoire: "Oxford Book of English Madrigals (ISBN 9780193436640)", number_of_sessions: 3, session_of_day: 'Session 1'})
course_choral.klasses.create({title: "Oratorio Choir", description: "Mendelssohn Christus and Psalm 13 new editions by Neil Jenkins, published Barn End Press.", repertoire: "Mendelssohn Christus and Psalm 13, new editions by Neil Jenkins, published Barns End Press. Mendelssohn Hear my prayer, published by Novello, NOV291599", number_of_sessions: 6, session_of_day: 'Session 2'})
course_choral.klasses.create({title: "Compline Choir", description: "This choir will rehearse the music for a service of Compline on the Wednesday evening. The Compline service at AIMS is a wonderful midpoint of the week. It is a chance to take some time out from the rus, and enjoy some beautiful sacred works, both accompanied and a capella.", repertoire: "Music for the Funeral of Queen Mary, Purcell, Burial Sentences, Croft, Nunc Dimittis, Howell, and motets from Elizabethan/Tudor period.", session_of_day: "Session 3", number_of_sessions: 3})
course_choral.klasses.create({title: "AIMS Choir", description: "All choral students are encouraged to sing in the AIMS Choir", repertoire: "Haydn The Seasons (Autumn & Winter) published by Barn End Press", session_of_day: 'Session 4', number_of_sessions: '6'})

course_dropin.klasses.create({title: "Stagecraftt", description: "Taken by our Opera Directors, these classes cover various aspects of acting technique. They are lively, with lots of participation for all. Specific themes will be covered"})

CourseFormat.delete_all
format_summer = CourseFormat.create({title: "Summer School", description: "The Summer School is a week-long residential course at the beautiful seaside of East Bourne. The You will be joining around 200 enthusiastic students, along with 70 staff made up of tutors and house pianists. There four main teaching sessions per day, with lots of performance opportunities.", whats_new: "2016 is very new", when_from: "2016-08-21 08:53:20", when_to: "2016-08-28 21:53:20", venue: "EastBourne College", address1: "Old Wish Road", city: "EastBourne", county: "East Sussex", post_code: "BN21 4JY"})
format_mini = CourseFormat.create({title: "Mini-Aims", description: "Mini-Aims is our non-residential 'taster' version of the main singing summer school.", whats_new: "2016 is very new", when_from: "2016-04-09 08:53:20", when_to: "2016-04-10 21:53:20", venue: "St Gabriel's Halls", address1: "Pimlico", city: "London", county: "Greater London", post_code: "SW1V 3AA"})

Staff.delete_all
Staff.create({name: "John Ramster", biography: "Opera Director at the Royal Academy of Music", role: "tutor"})
Staff.create({name: "Ameral Gunson", biography: "Mezzo and vocal coach....", role: "tutor"})
Staff.create({name: "Eugene Asti", biography: "Song coach and pianist....", role: "tutor"})
Staff.create({name: "Terence Allbright", biography: "Pianist and cabarat...", role: "tutor"})
Staff.create({name: "Robert Dean", biography: "Vocal coach...", role: "tutor"})
Staff.create({name: "Hilary Fisher", biography: "Cabarat specialist...", role: "tutor"})
Staff.create({name: "Antonia Hyatt", biography: "General manager experience...", role: "General Manager"})
Staff.create({name: "Neil Jenkins", biography: "Experienced conductor, singer, and run AIMS for many years....", role: "Artistic Director"})
Staff.create({name: "Louisa Lam", biography: "GSMD fellow....", role: "house pianist"})

Event.delete_all
event1 = Event.create({title: "Choral Concert", description: "A selection of the chora pieces studied will be performed in a concert at the end of each day, alongside other solo items.", date: "2016-07-03 19:30:00", programme: "3 Shakespeare Songs Vaughan Williams", performers: "AIMS Choir. John Hancorn, conductor", venue: "St Gabriel's Halls", address1: "Pimlico", city: "London", county: "Greater London", post_code: "SW1V 3AA"})

Page.delete_all
page1 = Page.create({title: "Ticket Information", content: "You can buy tickets at the door"})

Fee.delete_all
format_summer.fees.create({fee_type: "Residential", category: "Shared Rooms", description: "Dormitory(3-5 beds)", amount: "665"})
format_summer.fees.create({fee_type: "Residential", category: "Shared Rooms", description: "Twin(3-5 beds)", amount: "700"})
format_summer.fees.create({fee_type: "Residential", category: "Single Rooms", description: "Basic Single", amount: "725"})
format_summer.fees.create({fee_type: "Residential", category: "Single Rooms", description: "Single in Tenby Lodge/Pennell", amount: "745"})
format_summer.fees.create({fee_type: "Non-Residential", category: "Solo A", description: "Includes lunch and supper, and entry to all concerts", amount: "530"})
format_summer.fees.create({fee_type: "Non-Residential", category: "Choral A", description: "Includes lunch and supper, and entry to all concerts", amount: "530"})
format_summer.fees.create({fee_type: "Non-Residential", category: "Choral B", description: "No meals or evening concerts. Includes entry to lunchtime concerts only", amount: "375"})
format_summer.fees.create({fee_type: "Casual Visitors", category: "Observing", description: "Part day (morning or afternoon)", amount: "15"})
format_summer.fees.create({fee_type: "Casual Visitors", category: "Observing", description: "Full day", amount: "30"})
format_mini.fees.create({fee_type: "Mini-Aims", category: "Solo Singers", description: "Two days", amount: "190"})
format_mini.fees.create({fee_type: "Mini-Aims", category: "Solo Singers", description: "One day", amount: "100"})
format_mini.fees.create({fee_type: "Mini-Aims", category: "Choral Singers", description: "Two days", amount: "95"})
format_mini.fees.create({fee_type: "Mini-Aims", category: "Solo Singers", description: "One day", amount: "50"})
Fee.create({fee_type: "Event", category: "Concert", description: "Student Performance", amount: "10"})
Fee.create({fee_type: "Event", category: "Concert", description: "Gala Recital", amount: "15"})
Fee.create({fee_type: "Event", category: "Concert", description: "Tutor Concert", amount: "10"})
Fee.create({fee_type: "Event", category: "Concert", description: "Celebrity Masterclass", amount: "10"})
Fee.create({fee_type: "Event", category: "Concert", description: "Lunchtime Concerts", amount: "0"})

Quote.delete_all
Quote.create({saying: "Fabulous week at AIMS but then it always is! Lovely to see old friends and meet new ones, and share in this life-enhancing musical experience."})
Quote.create({saying: "As the week progressed, it was nice to know we alls hared the same vocal issues."})


