#gi1 = GlobalId.new
#gi1.row_id = 1
#gi1.id_counter = 1
#gi1.save

# Sample user
# username: allen
# password: allenc
u = User.new
u.login = "allen"
u.email = "example@example.com"
u.crypted_password = "44d1f9bd456ae2fb8558b1c4877227fbb16cf4e9"
u.salt = "756b488e613c4899fa16bf3e6c350e39c626296d"
u.save

u = User.new
u.put("login", "amber")
u.save

nw1 = Word.new
nw1.word = "indulged"
nw1.definition = "gratify give way to satisfy allow oneself"
nw1.save

nw2 = Word.new
nw2.word = "vex"
nw2.definition = "annoy distress trouble"
nw2.save

nw3 = Word.new
nw3.word = "chastened"
nw3.definition = "corrected, punished"
nw3.save

nw4 = Word.new
nw4.word = "discerned"
nw4.definition = "see with an effort but clearly"
nw4.save


# Set 'content' here as a full book corpus.
# This is really, really slow if you have a really big book.
# This is a lot of preprocessing.

b1 = Book.new
b1.name = "Wuthering Heights"
b1.save

wl1 = Wordlist.new
wl1.put("name", "amber")
wl1.save

wl2 = Wordlist.new
wl2.put("name", "hello")
wl2.save

ww1 = WordsWordlist.new
ww1.put("word_word", nw1)
ww1.put("wordlist_name", wl2)
ww1.save($piql_env)

ww2 = WordsWordlist.new
ww2.put("word_word", nw2)
ww2.put("wordlist_name", wl2)
ww2.save($piql_env)

ww3 = WordsWordlist.new
ww3.put("word_word", nw3)
ww3.put("wordlist_name", wl2)
ww3.save($piql_env)

ww4 = WordsWordlist.new
ww4.put("word_word", nw4)
ww4.put("wordlist_name", wl2)
ww4.save($piql_env)

bookline1 = BookLine.new
bookline1.put("line", "But one day, when she had been peculiarly wayward, rejecting her breakfast, complaining that the servants did not do what she told them; that the mistress would allow her to be nothing in the house, and Edgar neglected her; that she had caught a cold with the doors being left open, and we let the parlour fire go out on purpose to vex her, with a hundred yet more frivolous accusations, Mrs. Linton peremptorily insisted that she should get to bed; and, having scolded her heartily, threatened to send for the doctor.")
#bookline1.put("linenum", 1)
bookline1.put("source", b1)
bookline1.save($piql_env)

c1 = Context.new
c1.context_id = java.lang.Integer.new(1)
c1.wordline = bookline1.line
c1.before = ""
c1.after = ""
c1.book_name = b1
c1.word_word = nw2
c1.save

wr1 = WordReference.new
wr1.word_word = nw2
wr1.context_id = c1
wr1.save

bookline2 = BookLine.new
bookline2.put("line", "That sounds ill-natured: but she was so proud it became really impossible to pity her distresses, till she should be chastened into more humility.")
#bookline2.put("linenum", 2)
bookline2.put("source", b1)
bookline2.save($piql_env)

c2 = Context.new
c2.context_id = java.lang.Integer.new(2)
c2.wordline = bookline2.line
c2.before = ""
c2.after = ""
c2.book_name = b1
c2.word_word = nw3
c2.save

wr2 = WordReference.new
wr2.word_word = nw3
wr2.context_id = c2
wr2.save

bookline3 = BookLine.new
bookline3.put("line", "‘It’s well the hellish villain has kept his word!’ growled my future host, searching the darkness beyond me in expectation of discovering Heathcliff; and then he indulged in a soliloquy of execrations, and threats of what he would have done had the ‘fiend’ deceived him.")
#bookline3.put("linenum", 3)
bookline3.put("source", b1)
bookline3.save($piql_env)

c3 = Context.new
c3.context_id = java.lang.Integer.new(3)
c3.wordline = bookline3.line
c3.before = ""
c3.after = ""
c3.book_name = b1
c3.word_word = nw1
c3.save

wr3 = WordReference.new
wr3.word_word = nw1
wr3.context_id = c3
wr3.save

bookline4 = BookLine.new
bookline4.put("line", "As it spoke, I discerned, obscurely, a child's face looking through the window.  Terror made me cruel; and, finding it useless to attempt shaking the creature off, I pulled its wrist on to the broken pane, and rubbed it to and fro till the blood ran down and soaked the bedclothes: still it wailed, 'Let me in!' and maintained its tenacious gripe, almost maddening me with fear.")
bookline4.put("source", b1)
bookline4.save($piql_env)

c4 = Context.new
c4.context_id = java.lang.Integer.new(4)
c4.wordline = bookline4.line
c4.before = ""
c4.after = ""
c4.book_name = b1
c4.word_word = nw4
c4.save

wr4 = WordReference.new
wr4.word_word = nw1
wr4.context_id = c4
wr4.save