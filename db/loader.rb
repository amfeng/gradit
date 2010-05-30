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

wl = Wordlist.new
wl.put("name", "amber")
wl.save

wl = Wordlist.new
wl.put("name", "hello")
wl.save

ww = WordsWordlist.new
ww.put("word_word", nw1)
ww.put("wordlist_name", wl)
ww.save($piql_env)

ww = WordsWordlist.new
ww.put("word_word", nw2)
ww.put("wordlist_name", wl)
ww.save($piql_env)

ww = WordsWordlist.new
ww.put("word_word", nw3)
ww.put("wordlist_name", wl)
ww.save($piql_env)

ww = WordsWordlist.new
ww.put("word_word", nw4)
ww.put("wordlist_name", wl)
ww.save($piql_env)

