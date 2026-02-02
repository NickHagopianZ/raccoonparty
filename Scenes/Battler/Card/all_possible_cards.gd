extends Resource

class_name AllPossibleCards

var card_list : Array[CardResource] = [
	sip_drink,
	back_flip,
	jam,
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
	dumpster,
	suzanne,
	dimitri,
]

static var suzanne = CardResource.new(
	"Suzanne",
	"The mailbox letter was being sent by Suzanne",
	[BattleScores.new("Change", "Sus", 10),
	BattleScores.new("Change", "Vibes", 5)],
	"Suzanne and I are close buds.",
	["Bouncer"]
)

static var dimitri = CardResource.new(
	"Dimitri",
	"The mailbox letter was being sent to Dimitri",
	[],
	"Dimitri and I go waaayyy back.",
	["Bouncer"]
)

static var sip_drink = CardResource.new(
	"Sip Drink",
	"Take sips of your drink with your weird, weird, hands.\n\n+2 Vibes\n-1 Sus",
	[BattleScores.new("Change", "Vibes", 2), BattleScores.new("Change", "Sus", -1)],
	"Take sips of your drink with your weird, weird, hands.",
)
static var back_flip = CardResource.new(
	"Back Flip",
	"Could a raccoon do this??\n\n*backflips*\n\n+1 Vibes\nD1 Sus",
	[BattleScores.new("Change", "Vibes", 1), BattleScores.new("Defend", "Sus", 1)],
	"Could a raccoon do this??\n\n*backflips*",
)
static var jam = CardResource.new(
	"This is My Jam",
	"This. Is. My. JAM!\n\n+1 Vibes\n-1 Fear\nD1 Sus",
	[BattleScores.new("Change", "Vibes", 1), BattleScores.new("Change", "Fear", -1), BattleScores.new("Defend", "Sus", 1)],
	"This. Is. My. JAM!",
)
static var nice_shoes = CardResource.new(
	"Nice Shoes",
	"I like those shoes, are they gucci?\n\n+1 Vibes\nD1 Sus",
	[BattleScores.new("Change", "Vibes", 1), BattleScores.new("Defend", "Sus", 1)],
	"I like those shoes, are they gucci?",
)
static var nod_along = CardResource.new(
	"Nod Along",
	"Mhmmm. Yeah. Of course.\n\n+1 Vibes\nD1 Fear\nD1 Sus",
	[BattleScores.new("Change", "Vibes", 1), BattleScores.new("Defend", "Fear", 1), BattleScores.new("Defend", "Sus", 1)],
	"Mhmmm. Yeah. Of course.",
)
static var shots = CardResource.new(
	"Shots! Shots! Shots!",
	"Shots! Shots! Shots!\n\n+1 Vibes\n-1 Fear\nD1 Sus",
	[BattleScores.new("Change", "Vibes", 1), BattleScores.new("Change", "Fear", -1), BattleScores.new("Defend", "Sus", 1)],
	"Shots! Shots! Shots!",
)
static var podcasts = CardResource.new(
	"Not the Podcasts",
	"I've got some podcasts that I think would really open your mind\n\n-1 Vibes\n+1 Fear",
	[BattleScores.new("Change", "Vibes", -1), BattleScores.new("Change", "Fear", 1)],
	"I've got some podcasts that I think would really open your mind",
)
static var sewer = CardResource.new(
	"Undergound Living",
	"I live in this nice place under 5th street...\n\n+2 Fear\n-1 Sus",
	[BattleScores.new("Change", "Fear", 2), BattleScores.new("Change", "Sus", -1)],
	"I live in this nice place under 5th street...",
)
static var growl = CardResource.new(
	"Growl",
	"grrrrrrrrrrrrrr\n\n+2 Fear\n-1 Sus",
	[BattleScores.new("Change", "Fear", 2), BattleScores.new("Change", "Sus", -1)],
	"grrrrrrrrrrrrrr",
)
static var hot_take = CardResource.new(
	"Hot Take",
	"I think height is a choice.\n\n-1 Vibes\n+2 Fear",
	[BattleScores.new("Change", "Vibes", -1), BattleScores.new("Change", "Fear", 2)],
	"I think height is a choice.",
)
static var gonna_eat_that = CardResource.new(
	"You Gonna Eat That?",
	"I could take that half eaten mushroom slider off your hands\n\n-1 Vibes\n+2 Fear\n-1 Sus",
	[BattleScores.new("Change", "Vibes", -1), BattleScores.new("Change", "Fear", 2), BattleScores.new("Change", "Sus", -1)],
	"I could take that half eaten mushroom slider off your hands",
)
static var garbage_man = CardResource.new(
	"Garbage Man",
	"Of course I don't eat trash, that would be pretty weird...\n\n+1 Fear\n+1 Sus",
	[BattleScores.new("Change", "Fear", 1), BattleScores.new("Change", "Sus", 1)],
	"Of course I don't eat trash, that would be pretty weird...",
)
static var have_we_met = CardResource.new(
	"Have We Met?",
	"Weren't we in Nocturnal Studies together?\n\nD1 Fear\n+1 Sus",
	[BattleScores.new("Defend", "Fear", 1), BattleScores.new("Change", "Sus", 1)],
	"Weren't we in Nocturnal Studies together?",
)
static var distraction = CardResource.new(
	"Distraction",
	"Look behind you! Is that John Wayne at the punch bowl?\n\nD1 Vibes\nD1 Fear\nD1 Sus",
	[BattleScores.new("Defend", "Vibes", 1), BattleScores.new("Defend", "Fear", 1), BattleScores.new("Defend", "Sus", 1)],
	"Look behind you! Is that John Wayne at the punch bowl?",
)
static var good_old_days = CardResource.new(
	"Good Old Days",
	"This city used to have trash bags lying around everywhere...\n\n-1 Vibes\n-1 Fear\n-1 Sus",
	[BattleScores.new("Change", "Vibes", -1), BattleScores.new("Change", "Fear", -1), BattleScores.new("Change", "Sus", -1)],
	"This city used to have trash bags lying around everywhere...",
)
static var dumpster = CardResource.new(
	"Dumpster Diving",
	"One time, when dumpster diving, I found a really juicy donut\n\n-1 Vibes\n-1 Fear\n-1 Sus",
	[BattleScores.new("Change", "Vibes", -1), BattleScores.new("Change", "Fear", -1), BattleScores.new("Change", "Sus", -1)],
	"One time, when dumpster diving, I found a really juicy donut",
)
