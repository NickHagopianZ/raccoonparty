extends Resource
class_name AllPossibleCards
static var sip_drink = CardResource.new(
"Sip Drink",
"Take sips of your drink with your weird, weird, hands.",
[BattleScores.new("Change", "Vibes", 2),
BattleScores.new("Change", "Sus", -1)],
"Take sips of your drink with your weird, weird, hands.",
)
static var back_flip = CardResource.new(
"Back Flip",
"Could a raccoon do this??\n\n*backflips*",
[BattleScores.new("Change", "Vibes", 1),
BattleScores.new("Defend", "Sus", 1)],
"Could a raccoon do this??\n\n*backflips*",
)
static var nice_shoes = CardResource.new(
"Nice Shoes",
"I like those shoes, are they gucci?",
[BattleScores.new("Change", "Vibes", 1),
BattleScores.new("Defend", "Sus", 1)],
"I like those shoes, are they gucci?",
)
static var nod_along = CardResource.new(
"Nod Along",
"Mhmmm. Yeah. Of course.",
[BattleScores.new("Change", "Vibes", 1),
BattleScores.new("Defend", "Fear", 1),
BattleScores.new("Defend", "Sus", 1)],
"Mhmmm. Yeah. Of course.",
)
static var shots = CardResource.new(
"Shots! Shots! Shots!",
"Shots! Shots! Shots!",
[BattleScores.new("Change", "Vibes", 1),
BattleScores.new("Change", "Fear", -1),
BattleScores.new("Defend", "Sus", 1)],
"Shots! Shots! Shots!",
)
static var podcasts = CardResource.new(
"Not the Podcasts",
"I've got some podcasts that I think would really open your mind",
[BattleScores.new("Change", "Vibes", -1),
BattleScores.new("Change", "Fear", 1)],
"I've got some podcasts that I think would really open your mind",
)
static var sewer = CardResource.new(
"Undergound Living",
"I live in this nice place under 5th street...",
[BattleScores.new("Change", "Fear", 2),
BattleScores.new("Change", "Sus", -1)],
"I live in this nice place under 5th street...",
)
static var growl = CardResource.new(
"Growl",
"grrrrrrrrrrrrrr",
[BattleScores.new("Change", "Fear", 2),
BattleScores.new("Change", "Sus", -1)],
"grrrrrrrrrrrrrr",
)
static var hot_take = CardResource.new(
"Hot Take",
"I think height is a choice.",
[BattleScores.new("Change", "Vibes", -1),
BattleScores.new("Change", "Fear", 2)],
"I think height is a choice.",
)
static var gonna_eat_that = CardResource.new(
"You Gonna Eat That?",
"I could take that half eaten mushroom slider off your hands",
[BattleScores.new("Change", "Vibes", -1),
BattleScores.new("Change", "Fear", 2),
BattleScores.new("Change", "Sus", -1)],
"I could take that half eaten mushroom slider off your hands",
)
static var garbage_man = CardResource.new(
"Garbage Man",
"Of course I don't eat trash, that would be pretty weird...",
[BattleScores.new("Change", "Fear", 1),
BattleScores.new("Change", "Sus", 1)],
"Of course I don't eat trash, that would be pretty weird...",
)
static var have_we_met = CardResource.new(
"Have We Met?",
"Weren't we in Nocturnal Studies together?",
[BattleScores.new("Defend", "Fear", 1),
BattleScores.new("Change", "Sus", 1)],
"Weren't we in Nocturnal Studies together?",
)
static var distraction = CardResource.new(
"Distraction",
"Look behind you! Is that John Wayne at the punch bowl?",
[BattleScores.new("Defend", "Vibes", 1),
BattleScores.new("Defend", "Fear", 1),
BattleScores.new("Defend", "Sus", 1)],
"Look behind you! Is that John Wayne at the punch bowl?",
)
static var good_old_days = CardResource.new(
"Good Old Days",
"This city used to have trash bags lying around everywhere...",
[BattleScores.new("Change", "Vibes", -1),
BattleScores.new("Change", "Fear", -1),
BattleScores.new("Change", "Sus", -1)],
"This city used to have trash bags lying around everywhere...",
)
static var dumpster = CardResource.new(
"Dumpster Diving",
"One time, when dumpster diving, I found a really juicy donut",
[BattleScores.new("Change", "Vibes", -1),
BattleScores.new("Change", "Fear", -1),
BattleScores.new("Change", "Sus", -1)],
"One time, when dumpster diving, I found a really juicy donut",
)
# Lists must be defined AFTER all card variables to avoid null references
static var basic_card_list : Array[CardResource] = [
sip_drink,
back_flip,
nice_shoes,
nod_along,
shots,
podcasts,
sewer,
growl,
hot_take,
gonna_eat_that,
garbage_man,
have_we_met,
distraction,
good_old_days,
dumpster
]
static var simone = CardResource.new(
"Simone",
"The mailbox letter was being sent by Simone",
[BattleScores.new("Change", "Sus", 10),
BattleScores.new("Change", "Vibes", 5)],
"Simone and I are close buds.",
false,
["Bouncer"]
)
static var dimitri = CardResource.new(
"Dimitri",
"The mailbox letter was being sent to Dimitri",
[],
"Dimitri and I go waaayyy back.",
false,
["Bouncer"]
)

static var mila = CardResource.new(
	"A side of snark", 
	"Mila mentioned Yesenia likes sarcasm", 
	[
		BattleScores.new("Change", "Vibes", 4),
		BattleScores.new("Weaken", "Sus", 3),
		BattleScores.new("Defend", "Fear", 2)
	],
	"Yeah, I'm totally a raccoon.",
	false,
	["Yesenia"]
)


static var raphael = CardResource.new(
"Fit check", "Raphael mentioned Lennox is into fashion", [
BattleScores.new("Change","Fear",1), 
BattleScores.new("Strengthen","Fear",5), 
BattleScores.new("Change","Vibes",-1)],"Florals? For Spring? Groundbreaking.",
false,["Lennox"]
)


static var jaxon1 = CardResource.new(
"Get bounced", "Jaxon mentioned Sutton is new in town", [
BattleScores.new("Defend","Sus",5), 
BattleScores.new("Defend","Fear",5), 
BattleScores.new("Defend","Vibes",5)],"Who do you know here?",false,["Sutton"])


static var jaxon2 = CardResource.new(
"Wax", "Jaxon mentioned Sutton likes poetry", [
BattleScores.new("Change","Vibes",3), 
BattleScores.new("Change","Fear",1), 
BattleScores.new("Change","Sus",2)],"What is man but an animal in a mask?",false,["Sutton"])


static var nolan = CardResource.new(
"Speech and debate", "Nolan mentioned Emese is logical", [
BattleScores.new("Change","Vibes",2),
BattleScores.new("Change","Fear",2),
BattleScores.new("Change","Sus",2)],"A well-constructed, 3 point argument.",false,["Emese"])


static var alex = CardResource.new(
"I love this song!", "Alex mentioned Freya is into music", [
BattleScores.new("Change","Vibes",3),BattleScores.new("Defend","Sus",3),BattleScores.new("Defend","Fear",3
)],"This. Is. My. Jam.",false,["Freya"])


static var natasha = CardResource.new(
"Awkward small talk", "Natasha mentioned June is an introvert", [
BattleScores.new("Change","Fear",5)],"How was your weekend?",false,["June"])

static var sergio = CardResource.new(
"A bag of flavor-blasted chips", "Sergio mentioned Curtis loves to snack", [
BattleScores.new("Weaken","Sus",1),BattleScores.new("Change","Vibes",5)],
"The trash humans will eat (+1 vibes, -1 sus)",false,["Curtis"])


static var yesenia = CardResource.new(
"You like my mask?", "Yesenia mentioned Luca put a lot of effort into his mask", [
BattleScores.new("Weaken","Sus",1),BattleScores.new("Change","Vibes",5)],
"Thanks, I grew it myself (+1 vibes, +1 sus, +1 fear)",false,["Luca"])

static var dillon1 = CardResource.new(
"Pest control", "Dillon mentioned Alejandro hates animals", [
BattleScores.new("Weaken","Sus",1),BattleScores.new("Change","Fear",6)],
"Animal control owes me a favor or two (-1 fear, -1 sus)",false,["Alejandro"])


static var dillon2 = CardResource.new(
"Animal lover", "Dillon mentioned Cheyenne loves animals", [
BattleScores.new("Change","Vibes",3),
BattleScores.new("Change","Fear",3),
BattleScores.new("Change","Sus",-1)],"I'm partial to raccoons myself"
,false,["Cheyenne"])


static var cheyenne = CardResource.new(
"Name drop", "Cheyenne mentioned Simone is close with Dillon", [
BattleScores.new("Change","Vibes",3),
BattleScores.new("Defend","Sus",10),
BattleScores.new("Change","Sus",3)],
"Dillon and I are tight.",false,["Simone"])


static var emese = CardResource.new(
"Back in the day", "Emese mentioned Simone went to University of College", [
BattleScores.new("Change","Vibes",4),
BattleScores.new("Strengthen", "Sus",3)],
"Didn't we meet at that party at University of College?",false,["Simone"])


static var backyard_raccoon = CardResource.new(
"Simone's Favorite Food", "Backyard Raccoon found this in Simone's trash", [
BattleScores.new("Weaken","Sus",1),
BattleScores.new("Change","Vibes",4),
BattleScores.new("Change","Fear",3)],"I got this for you",false,["Simone"])

static var fridge1 = CardResource.new(
"June's Secret Recipe",
"It doesn't even look like food",
[BattleScores.new("Change","Fear",2),
BattleScores.new("Strengthen","Fear",5),
BattleScores.new("Change","Vibes",-2)],
"June will be upset if you don't try this."
)


static var rumor_card_list : Array[CardResource] = [
simone,
dimitri,
mila,
raphael,
jaxon1,
jaxon2,
nolan,
alex,
natasha,
sergio,
yesenia,
dillon1,
dillon2,
cheyenne,
emese,
backyard_raccoon,
fridge1
]


# static var boom_box1 = CardResource.new(
# "Party Foul",
# "Who turned off the music?",
# [BattleScores.new("Exhaust","NONE",0)],
# "Oops. I was trying to turn it up."
# )

# static var boom_box2 = CardResource.new(
# "Now That's a Bop",
# "Feel the music",
# [BattleScores.new("Exhaust","NONE",0),
# BattleScores.new("Change","Vibes",4)],
# "**unce unce unce**"
# )

# static var desk1 = CardResource.new(
# "Remote Worker",
# "You really need to get out more",
# [BattleScores.new("Exhaust","NONE",0)],
# "Oops. I was trying to turn it up."
# )

# static var desk2 = CardResource.new(
# "Work-life balance",
# "Who turned off the music?",
# [BattleScores.new("Weaken","Sus",1),
# BattleScores.new("Change","Vibes",4)],
# "Oops. Did I was trying to turn it up."
# )

# static var beer_pong1 = CardResource.new(
# "Prince of Pong",
# "Who turned off the music?",
# [BattleScores.new("Weaken","Sus",1),
# BattleScores.new("Change","Vibes",4)],
# "Oops. Did I was trying to turn it up."
# )

# static var beer_pong2 = CardResource.new(
# "Losing team",
# "Who turned off the music?",
# [BattleScores.new("Weaken","Sus",1),
# BattleScores.new("Change","Vibes",4)],
# "Oops. Did I was trying to turn it up."
# )

# static var diary1 = CardResource.new(
# "Some hot goss",
# "Who turned off the music?",
# [BattleScores.new("Weaken","Sus",1),
# BattleScores.new("Change","Vibes",4)],
# "Oops. Did I was trying to turn it up."
# )

# static var diary2 = CardResource.new(
# "Loose lips",
# "Who turned off the music?",
# [BattleScores.new("Weaken","Sus",1),
# BattleScores.new("Change","Vibes",4)],
# "Oops. Did I was trying to turn it up."
# )


static var fridge2 = CardResource.new(
"Stink",
"It lingers",
[
	BattleScores.new("Change","Sus",-1),
	BattleScores.new("Change","Vibes",-2),
	BattleScores.new("Exhaust", "NONE", 0)	
],
"Whoever smelt it..."
)


static var penalty_card_list : Array[CardResource] = [
fridge2
]
static func level_adjust_reward(reward: Array[BattleScores], level: int) -> Array[BattleScores]:
	var adjusted_reward : Array[BattleScores] = []
	for battle_score in reward:
		var adjusted_battle_score : BattleScores = battle_score.duplicate_deep()
		adjusted_reward.append(adjusted_battle_score)
		# only if positive effects
		if (adjusted_battle_score.effect in [
			BattleScores.Effects.Change, BattleScores.Effects.Strengthen,
			BattleScores.Effects.Defend])  and adjusted_battle_score.amount > 0:
			adjusted_battle_score.amount += level
			break
	return adjusted_reward

static func random_reward(num_cards, level: int) -> Array[CardResource]:
	var rewards : Array[CardResource] = []
	var available_cards : Array[CardResource] = basic_card_list.duplicate()
	available_cards.shuffle()
	for i in range(num_cards):
		var chosen_card : CardResource = available_cards[i].duplicate_deep()
		chosen_card.actions = level_adjust_reward(
		chosen_card.actions, level)
		rewards.append(chosen_card)
	return rewards
