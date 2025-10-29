extends Resource
class_name Equipment

@export var name: String = "Equipment"
@export var long_range: bool = false                  # bows/whips ignore back-row penalty on attacker
@export var elements: Array[Element.Type] = []        # applied on physical only (typical JRPG convention)
@export var stat_bonus := {                           # flat bonuses
	"str": 0, "vit": 0, "agi": 0, "wis": 0, "wil": 0, 
	"atk": 0, "def": 0, "mag": 0, "mdef": 0
}
