extends Resource
class_name StatModifier

## Neutro é sempre 0. Negativo é debuff.
enum Kind {
	FLAT, ## Somado ao base: 10 vira +10.
	ADDITIVE, ## Percentual somado aos outros: 0.2 vira +20%.
	MULTIPLICATIVE, ## Percentual composto com os outros: 0.2 vira +20%.
}

@export var kind: Kind = Kind.FLAT
@export var amount: float = 0.0
@export var source: StringName = &""


func _init(p_kind := Kind.FLAT, p_amount := 0.0, p_source := &"") -> void:
	kind = p_kind
	amount = p_amount
	source = p_source
