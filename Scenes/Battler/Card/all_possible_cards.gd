extends Node

class_name AllPossibleCards


static var sip_drink = CardResource.new(
	"Sip Drink",
	"Take sips of your drink with your weird, [i]weird[/i], hands.\n\n+2 Vibes\n-1 Sus",
	[BattleScores.Action.new("+2 Vibes"), BattleScores.Action.new("-1 Sus")]
)
static var back_flip = CardResource.new(
	"Back Flip",
	"Could a raccoon do [i]this[/i]??\n\n  [b][i]backflips[/i][/b]\n\n+1 Vibes\nD1 Sus",
	[BattleScores.Action.new("+1 Vibes"), BattleScores.Action.new("D1 Sus")]
)
static var growl = CardResource.new(
	"Growl",
	"[i]grrrrrrrrrrrrrr[/i]\n\n+2 Fear\n-1 Sus",
	[BattleScores.Action.new("+2 Fear"), BattleScores.Action.new("-1 Sus")]
)
static var jam = CardResource.new(
	"This is My Jam",
	"This. Is. My. JAM!\n\n+1 Vibes\n-1 Fear\nD1 Sus",
	[BattleScores.Action.new("+1 Vibes"), BattleScores.Action.new("-1 Fear"), BattleScores.Action.new("D1 Sus")]
)
static var garbage_man = CardResource.new(
	"Garbage Man",
	"Of course I don't eat [i]trash[/i], that would be pretty weird...\n\n+1 Sus",
	[BattleScores.Action.new("+1 Sus")]
)
static var distraction = CardResource.new(
	"Distraction",
	"Look behind you! Is that John Wayne at the punch bowl?\n\nD1 Vibes\nD1 Fear\nD1 Sus",
	[BattleScores.Action.new("D1 Vibes"), BattleScores.Action.new("D1 Fear"), BattleScores.Action.new("D1 Sus")]
)
static var hot_take = CardResource.new(
	"Hot Take",
	"I think height is a choice.\n\n-1 Vibes\n+2 Fear",
	[BattleScores.Action.new("-1 Vibes"), BattleScores.Action.new("+2 Fear")]
)
static var have_we_met = CardResource.new(
	"Have We Met?",
	"Weren't we in Nocturnal Studies together?\n\nD1 Fear\n+1 Sus",
	[BattleScores.Action.new("D1 Fear"), BattleScores.Action.new("+1 Sus")]
)
