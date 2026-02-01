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
]

static var sip_drink = CardResource.new(
	"Sip Drink",
	"Take sips of your drink with your weird, weird, hands.\n\n+2 Vibes\n-1 Sus",
	[BattleScores.new("+2 Vibes"), BattleScores.new("-1 Sus")],
	"Take sips of your drink with your weird, weird, hands.",
)
static var back_flip = CardResource.new(
	"Back Flip",
	"Could a raccoon do this??\n\n*backflips*\n\n+1 Vibes\nD1 Sus",
	[BattleScores.new("+1 Vibes"), BattleScores.new("D1 Sus")],
	"Could a raccoon do this??\n\n*backflips*",
)
static var jam = CardResource.new(
	"This is My Jam",
	"This. Is. My. JAM!\n\n+1 Vibes\n-1 Fear\nD1 Sus",
	[BattleScores.new("+1 Vibes"), BattleScores.new("-1 Fear"), BattleScores.new("D1 Sus")],
	"This. Is. My. JAM!",
)
static var nice_shoes = CardResource.new(
	"Nice Shoes",
	"I like those shoes, are they gucci?\n\n+1 Vibes\nD1 Sus",
	[BattleScores.new("+1 Vibes"), BattleScores.new("D1 Sus")],
	"I like those shoes, are they gucci?",
)
static var nod_along = CardResource.new(
	"Nod Along",
	"Mhmmm. Yeah. Of course.\n\n+1 Vibes\nD1 Fear\nD1 Sus",
	[BattleScores.new("+1 Vibes"), BattleScores.new("D1 Fear"), BattleScores.new("D1 Sus")],
	"Mhmmm. Yeah. Of course.",
)
static var shots = CardResource.new(
	"Shots! Shots! Shots!",
	"Shots! Shots! Shots!\n\n+1 Vibes\n-1 Fear\nD1 Sus",
	[BattleScores.new("+1 Vibes"), BattleScores.new("-1 Fear"), BattleScores.new("D1 Sus")],
	"Shots! Shots! Shots!",
)
static var podcasts = CardResource.new(
	"Not the Podcasts",
	"I've got some podcasts that I think would really open your mind\n\n-1 Vibes\n+1 Fear",
	[BattleScores.new("-1 Vibes"), BattleScores.new("+1 Fear")],
	"I've got some podcasts that I think would really open your mind",
)
static var sewer = CardResource.new(
	"Undergound Living",
	"I live in this nice place under 5th street...\n\n+2 Fear\n-1 Sus",
	[BattleScores.new("+2 Fear"), BattleScores.new("-1 Sus")],
	"I live in this nice place under 5th street...",
)
static var growl = CardResource.new(
	"Growl",
	"grrrrrrrrrrrrrr\n\n+2 Fear\n-1 Sus",
	[BattleScores.new("+2 Fear"), BattleScores.new("-1 Sus")],
	"grrrrrrrrrrrrrr",
)
static var hot_take = CardResource.new(
	"Hot Take",
	"I think height is a choice.\n\n-1 Vibes\n+2 Fear",
	[BattleScores.new("-1 Vibes"), BattleScores.new("+2 Fear")],
	"I think height is a choice.",
)
static var gonna_eat_that = CardResource.new(
	"You Gonna Eat That?",
	"I could take that half eaten mushroom slider off your hands\n\n-1 Vibes\n+2 Fear\n-1 Sus",
	[BattleScores.new("-1 Vibes"), BattleScores.new("+2 Fear"), BattleScores.new("-1 Sus")],
	"I could take that half eaten mushroom slider off your hands",
)
static var garbage_man = CardResource.new(
	"Garbage Man",
	"Of course I don't eat trash, that would be pretty weird...\n\n+1 Fear\n+1 Sus",
	[BattleScores.new("+1 Fear"), BattleScores.new("+1 Sus")],
	"Of course I don't eat trash, that would be pretty weird...",
)
static var have_we_met = CardResource.new(
	"Have We Met?",
	"Weren't we in Nocturnal Studies together?\n\nD1 Fear\n+1 Sus",
	[BattleScores.new("D1 Fear"), BattleScores.new("+1 Sus")],
	"Weren't we in Nocturnal Studies together?",
)
static var distraction = CardResource.new(
	"Distraction",
	"Look behind you! Is that John Wayne at the punch bowl?\n\nD1 Vibes\nD1 Fear\nD1 Sus",
	[BattleScores.new("D1 Vibes"), BattleScores.new("D1 Fear"), BattleScores.new("D1 Sus")],
	"Look behind you! Is that John Wayne at the punch bowl?",
)
static var good_old_days = CardResource.new(
	"Good Old Days",
	"This city used to have trash bags lying around everywhere...\n\n-1 Vibes\n-1 Fear\n-1 Sus",
	[BattleScores.new("-1 Vibes"), BattleScores.new("-1 Fear"), BattleScores.new("-1 Sus")],
	"This city used to have trash bags lying around everywhere...",
)
static var dumpster = CardResource.new(
	"Dumpster Diving",
	"One time, when dumpster diving, I found a really juicy donut\n\n-1 Vibes\n-1 Fear\n-1 Sus",
	[BattleScores.new("-1 Vibes"), BattleScores.new("-1 Fear"), BattleScores.new("-1 Sus")],
	"One time, when dumpster diving, I found a really juicy donut",
)
