extends Node
class_name AllNPCActions

static var actions: Dictionary[int, NPCAction] = {
	# Targets Vibes
	0: NPCAction.new("I don't really know anyone here...", [["Change", "Vibes", -1]]),
	1: NPCAction.new("Honestly I'm more into, like, taller guys", [["Change", "Vibes", -1]]),
	2: NPCAction.new("I moved here to be closer to family, but I don't like my family.", [["Change", "Vibes", -1]]),

	# Targets Sus
	3: NPCAction.new("Do you always dress like that?", [["Change", "Sus", -1], ["Discard", "NONE", 1]]),
	4: NPCAction.new("Your cologne is... intereseting. Very earthy. Compost-like.", [["Nullify", "Vibes", 1], ["Change", "Sus", -1]]),
	5: NPCAction.new("Did I see you crawling out of a dumpster just before the party?", [["Change", "Sus", -1]]),

	# Targets Fear
	6: NPCAction.new("Your mask is SOOOO cute!", [["Change", "Fear", -1], ["Nullify", "Sus", 1]]),
	7: NPCAction.new("Yeah, I can basically bench around 450 now", [["Change", "Fear", -1], ["Nullify", "Vibes", 1]]),

	# Defense
	8: NPCAction.new("Huh? Sorry. I was looking at my phone.", [["Nullify", "Vibes", 1], ["Nullify", "Fear", 1], ["Weaken", "Vibes", 2], ["Weaken", "Fear", 2]]),
	9: NPCAction.new("I've been getting more into bird watching recently", [["Nullify", "Fear", 1], ["Nullify", "Sus", 1], ["Weaken", "Fear", 2], ["Weaken", "Sus", 2]]),
	10: NPCAction.new("So, uh, what do you do for work?", [["Nullify", "Vibes", 1], ["Weaken", "Vibes", 3]]),
	11: NPCAction.new("What kind of music do you listen to?", [["Nullify", "Sus", 1], ["Nullify", "Fear", 1], ["Weaken", "Fear", 2], ["Weaken", "Sus", 2]]),

	# Misc
	12: NPCAction.new("Sorry! I thought you were someone's pet dog!", [["Change", "Vibes", 1], ["Change", "Fear", -1], ["Change", "Sus", -1]]),
}

static var named_collections : Dictionary = {
	"Bouncer":[NPCAction.new("Who do you know?", [["Change", "Sus", -5]])],
	"Simone":[
		NPCAction.new("Why didn't the bouncer stop you?", [["Change", "Vibes", -3], ["Change", "Sus", -1]]),
		NPCAction.new("This is my party, you know.", [["Change", "Sus", -2], ["Change", "Sus", -1]]),
		NPCAction.new("I don't appreciate uninvited guests.", [["Change", "Vibes", -2], ["Change", "Sus", -1]]),
		NPCAction.new("Get off my property!", [["Change", "Vibes", -3], ["Change", "Sus", -1]]),
	],
}

static var archetype_collections : Dictionary[String, Array] = {
	"Bully" : [1, 2, 3, 4, 5, 7, 12],
	"Animal Lover" : [6, 9, 11, 12],
	"Quiet One" : [0, 2, 8, 10]
}

static func get_named_collection(collection_name: String) -> Array[NPCAction]:
	var npc_actions : Array[NPCAction] = []
	if named_collections.has(collection_name):
		for action in named_collections[collection_name]:
			npc_actions.append(action)
	return npc_actions

static func get_archetype_collection(archetype: String, level : int) -> Array[NPCAction]:
	var npc_actions : Array[NPCAction] = []
	if archetype_collections.has(archetype):
		var indices : Array = archetype_collections[archetype]
		for index in indices:
			if actions.has(index):
				npc_actions.append(level_adjust_action(actions[index].duplicate_deep(), level))
		return npc_actions
	return npc_actions

static func get_random_actions(num_actions: int, level : int) -> Array[NPCAction]:
	var action_indices = range(actions.size())
	action_indices.shuffle()

	var chosen_npc_actions : Array[NPCAction] = []
	for i in action_indices.slice(0, num_actions):
		var chosen_npc_action : NPCAction = actions[i].duplicate_deep()
		chosen_npc_action = level_adjust_action(chosen_npc_action, level)
		chosen_npc_actions.append(chosen_npc_action)
	return chosen_npc_actions


static func level_adjust_action(chosen_npc_action: NPCAction, level : int) -> NPCAction:
	var action_count : int = chosen_npc_action.actions.size()
	var chosen_action : BattleScores = chosen_npc_action.actions[randi_range(0, action_count - 1)]
	if (chosen_action.effect == BattleScores.Effects.Change and 
		chosen_action.amount > 0):
		pass
	else:
		chosen_action.amount -= level
	return chosen_npc_action
