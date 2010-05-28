# Sample user
# username: allen
# password: allenc
u = User.new
u.login = "allen"
u.email = "example@example.com"
u.crypted_password = "44d1f9bd456ae2fb8558b1c4877227fbb16cf4e9"
u.salt = "756b488e613c4899fa16bf3e6c350e39c626296d"
u.created_at = Time.now
u.activated_at = Time.now
u.updated_at = Time.now
u.save

Word.create :word => "abate", :definition => "to lessen to subside "
Word.create :word => "abdication", :definition => "giving up control authority "
Word.create :word => "aberration", :definition => "straying away from what is normal "
Word.create :word => "abet", :definition => "help/encourage smb (in doing wrong) "
Word.create :word => "abeyance", :definition => "suspended action "
Word.create :word => "attenuate", :definition => "make thin. weaken enervate "
Word.create :word => "attune", :definition => "bring into harmony "
Word.create :word => "audacious", :definition => "daring foolishly bold impudent "
Word.create :word => "chastened", :definition => "corrected punished "
Word.create :word => "chastisement", :definition => "punishment "
Word.create :word => "corroboration", :definition => "additional strengthening evidence "
Word.create :word => "countenance", :definition => "to favor or approve of "
Word.create :word => "counterfeit", :definition => "forgery "
Word.create :word => "countervail", :definition => "counterbalance "
Word.create :word => "covert", :definition => "disguised "
Word.create :word => "covetous", :definition => "eagerly desirous "
Word.create :word => "dilate", :definition => "speak comprehensively become wider large "
Word.create :word => "disallow", :definition => "refuse to allow or accept as a correct "
Word.create :word => "discern", :definition => "see with an effort but clearly "
Word.create :word => "entangle", :definition => "put into difficulties "
Word.create :word => "enthral", :definition => "please greatly/enslave (fig) "
Word.create :word => "florid", :definition => "very much ornamented naturally red (e.g.. of face) "
Word.create :word => "flout", :definition => "reject mock to go against (as in going against tradition) "
Word.create :word => "fluke", :definition => "lucky stroke "
Word.create :word => "fluster", :definition => "make nervous or confused "
Word.create :word => "highbrow", :definition => "(person) with superior tastes "
Word.create :word => "hirsute", :definition => "hairy shaggy "
Word.create :word => "indomitable", :definition => "not easily discouraged or subdued "
Word.create :word => "indulge", :definition => "gratify give way to satisfy allow oneself "
Word.create :word => "indulgent", :definition => "inclined to indulge "
Word.create :word => "malapropism", :definition => "misuse of a word (for one that resembles it) "
Word.create :word => "obtuse", :definition => "blunt/stupid "
Word.create :word => "obviate", :definition => "to make unnecessary get rid of "
Word.create :word => "overweening", :definition => "presumptuously arrogant overbearing immoderate being a jerk "
Word.create :word => "paean", :definition => "song of praise or triumph "
Word.create :word => "pivotal", :definition => "of great importance (others depend on it) "
Word.create :word => "placate", :definition => "soothe pacify calm "
Word.create :word => "pry", :definition => "get something inquire too curiously "
Word.create :word => "savor", :definition => "taste flavor something"
Word.create :word => "sawdust", :definition => "tiny bits of wood "
Word.create :word => "scabbard", :definition => "sheath for the blade "
Word.create :word => "sober", :definition => "self-controlled "
Word.create :word => "sobriety", :definition => "quality or condition of being sober "
Word.create :word => "sodden", :definition => "soaked saturated "
Word.create :word => "stentorian", :definition => "extremely loud and powerful "
Word.create :word => "suborn", :definition => "induce by bribery or something to commit perjury "
Word.create :word => "subpoena", :definition => "written order requiring a person to appear in a low court "
Word.create :word => "vex", :definition => "annoy distress trouble "


# Set 'content' here as a full book corpus.
# This is really, really slow if you have a really big book.
# This is a lot of preprocessing.

content = ""

content = content.scan(/[^\.\?\!]+[\.\?\!]+[\n]*/)
allwords = Word.all
num = 0
for line in content
	a = BookLine.new(:line=>line,:linenum=>num)
	a.source = book.id
	a.save
	for word in allwords
		reg = /\b#{query}\b/i
		if (reg.match(line))
			wr = WordReference.new
			wr.word = word.id
			wr.bookline = a.id
		end
	end
	num=num+1
end

# Create some wordlists so we can actually play games.

wl = Wordlist.new
wl.name = "Wordlist 1"
wl.description = "A quick, sample word list for the game."
wl.words << Word.find(1)
wl.words << Word.find(2)
wl.words << Word.find(3)
wl.save

