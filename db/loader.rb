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

nw = Word.new
nw.word = "indulged"
nw.definition = "gratify give way to satisfy allow oneself"
nw.save

nw = Word.new
nw.word = "vex"
nw.definition = "annoy distress trouble"
nw.save

nw = Word.new
nw.word = "chastened"
nw.definition = "corrected, punished"
nw.save

nw = Word.new
nw.word = "discerned"
nw.definition = "see with an effort but clearly"
nw.save


# Set 'content' here as a full book corpus.
# This is really, really slow if you have a really big book.
# This is a lot of preprocessing.

b1 = Book.new
b1.name = "Wuthering Heights"
b1.save

wl = Wordlist.new
wl.name = "Wordlist 1"
wl.description = "A quick, sample word list for the game."
wl.save

