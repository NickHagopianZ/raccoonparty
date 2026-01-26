extends Resource
class_name Card

# Just for example at the moment, but this could be list of effects, etc.
enum TagKinds {
	Tag1,
	Tag2
}

@export var title: String
@export_multiline var description: String # Multiline gives you a bigger text box
@export var tags: Array[TagKinds]

# A Resource still needs a parameterless constructor to save/load properly,
# so we give the arguments default values.
func _init(
	p_title: String = "",
	p_description: String = "",
	p_tags: Array[TagKinds] = []
):
	title = p_title
	description = p_description
	tags = p_tags
