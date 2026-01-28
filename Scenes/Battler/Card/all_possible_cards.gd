extends Node

class_name AllPossibleCards


static var sip_drink = CardResource.new(
	"Sip Drink",
	"Take sips of a drink with your weird hands.\n\n+2 Vibes\n-1 Sus",
	[BattleScores.Action.new("+2 Vibes"), BattleScores.Action.new("-1 Sus")]
)
static var backflip = CardResource.new(
	"Back Flip",
	"Could a raccoon do [i]this[/i]??\n\n[b][i]backflip[/i][/b]\n\n+1 Vibes\nD1 Sus",
	[BattleScores.Action.new("+1 Vibes"), BattleScores.Action.new("D1 Sus")]
)
static var growl = CardResource.new(
	"Growl",
	"[i]grrrrrrrr[/i]\n\n+2 Fear\n-1 Sus",
	[BattleScores.Action.new("+2 Fear"), BattleScores.Action.new("-1 Sus")]
)
