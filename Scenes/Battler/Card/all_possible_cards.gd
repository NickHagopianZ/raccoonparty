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
	[BattleScores.new("+2 Vibes"), BattleScores.new("-1 Sus")]
)
static var back_flip = CardResource.new(
	"Back Flip",
	"Could a raccoon do this??\n\n*backflips*\n\n+1 Vibes\nD1 Sus",
	[BattleScores.new("+1 Vibes"), BattleScores.new("D1 Sus")]
)
static var jam = CardResource.new(
	"This is My Jam",
	"This. Is. My. JAM!\n\n+1 Vibes\n-1 Fear\nD1 Sus",
	[BattleScores.new("+1 Vibes"), BattleScores.new("-1 Fear"), BattleScores.new("D1 Sus")]
)
static var nice_shoes = CardResource.new(
	"Nice Shoes",
	"I like those shoes, are they gucci?\n\n+1 Vibes\nD1 Sus",
	[BattleScores.new("+1 Vibes"), BattleScores.new("D1 Sus")]
)
static var nod_along = CardResource.new(
	"Nod Along",
	"Mhmmm. Yeah. Of course.\n\n+1 Vibes\nD1 Fear\nD1 Sus",
	[BattleScores.new("+1 Vibes"), BattleScores.new("D1 Fear"), BattleScores.new("D1 Sus")]
)
static var shots = CardResource.new(
	"Shots! Shots! Shots!",
	"Shots! Shots! Shots!\n\n+1 Vibes\n-1 Fear\nD1 Sus",
	[BattleScores.new("+1 Vibes"), BattleScores.new("-1 Fear"), BattleScores.new("D1 Sus")]
)
static var podcasts = CardResource.new(
	"Not the Podcasts",
	"I've got some podcasts that I think would really open your mind\n\n-1 Vibes\n+1 Fear",
	[BattleScores.new("-1 Vibes"), BattleScores.new("+1 Fear")]
)
static var sewer = CardResource.new(
	"Undergound Living",
	"Yeah, I've been living in this really nice sewer right off 5th street for about 3 years...\n\n+2 Fear\n-1 Sus",
	[BattleScores.new("+2 Fear"), BattleScores.new("-1 Sus")]
)
static var growl = CardResource.new(
	"Growl",
	"grrrrrrrrrrrrrr\n\n+2 Fear\n-1 Sus",
	[BattleScores.new("+2 Fear"), BattleScores.new("-1 Sus")]
)
static var hot_take = CardResource.new(
	"Hot Take",
	"I think height is a choice.\n\n-1 Vibes\n+2 Fear",
	[BattleScores.new("-1 Vibes"), BattleScores.new("+2 Fear")]
)
static var gonna_eat_that = CardResource.new(
	"You Gonna Eat That?",
	"I could take that half eaten mushroom slider off your hands\n\n-1 Vibes\n+2 Fear\n-1 Sus",
	[BattleScores.new("-1 Vibes"), BattleScores.new("+2 Fear"), BattleScores.new("-1 Sus")]
)
static var garbage_man = CardResource.new(
	"Garbage Man",
	"Of course I don't eat trash, that would be pretty weird...\n\n+1 Fear\n+1 Sus",
	[BattleScores.new("+1 Fear"), BattleScores.new("+1 Sus")]
)
static var have_we_met = CardResource.new(
	"Have We Met?",
	"Weren't we in Nocturnal Studies together?\n\nD1 Fear\n+1 Sus",
	[BattleScores.new("D1 Fear"), BattleScores.new("+1 Sus")]
)
static var distraction = CardResource.new(
	"Distraction",
	"Look behind you! Is that John Wayne at the punch bowl?\n\nD1 Vibes\nD1 Fear\nD1 Sus",
	[BattleScores.new("D1 Vibes"), BattleScores.new("D1 Fear"), BattleScores.new("D1 Sus")]
)
static var good_old_days = CardResource.new(
	"Good Old Days",
	"Remember when this city used to have its trash just right on the street? Those were the days\n\n-1 Vibes\n-1 Fear\n-1 Sus",
	[BattleScores.new("-1 Vibes"), BattleScores.new("-1 Fear"), BattleScores.new("-1 Sus")]
)
static var dumpster = CardResource.new(
	"Dumpster Diving",
	"This one time, when dumpster diving, I found this really juicy donut\n\n-1 Vibes\n-1 Fear\n-1 Sus",
	[BattleScores.new("-1 Vibes"), BattleScores.new("-1 Fear"), BattleScores.new("-1 Sus")]
)
