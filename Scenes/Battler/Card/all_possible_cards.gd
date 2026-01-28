extends Node

class_name AllPossibleCards


static var sip_drink = CardResource.new(
	"Sip Drink",
	"Take sips of a drink with your weird hands.\n\n+2 Vibes\n-1 Sus",
	[BattleScores.Effects.Change, BattleScores.Effects.Change],
	[BattleScores.ScoreCategories.Vibes, BattleScores.ScoreCategories.Suspicion],
	[2, -1]
)
static var backflip = CardResource.new(
	"Back Flip",
	"Could a raccoon do [i]this[/i]??\n\n[b][i]backflip[/i][/b]\n\n+1 Vibes\nB1 Sus",
	[BattleScores.Effects.Change, BattleScores.Effects.Defend],
	[BattleScores.ScoreCategories.Vibes, BattleScores.ScoreCategories.Suspicion],
	[1, 1]
)
static var growl = CardResource.new(
	"Growl",
	"[i]grrrrrrrr[/i]\n\n+2 Fear\n-1 Sus",
	[BattleScores.Effects.Change, BattleScores.Effects.Change],
	[BattleScores.ScoreCategories.Fear, BattleScores.ScoreCategories.Suspicion],
	[2, -1]
)
