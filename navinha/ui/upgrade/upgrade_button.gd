extends Button

var upgrade_number = randi() % 3
func set_upgrade():
	if upgrade_number == 0:
		text = "Max Health + 10"
	if upgrade_number == 1:
		text = "Max Booster + 10"
	if upgrade_number == 2:
		text = "Bullet Time 10% Faster"

func call_upgrade():
	if upgrade_number == 1:
		more_life()
	if upgrade_number == 2:
		more_booster()
	if upgrade_number == 3:
		faster_shoot()

func more_life():
	pass

func more_booster():
	%Player.stats.max_boost.add_modifier(
		StatModifier.new(StatModifier.Kind.FLAT, 10.0, &"upgrade"))
	print(%Player.stats.max_boost.value)

func faster_shoot():
	%Player.stats.fire_rate.add_modifier(
		StatModifier.new(StatModifier.Kind.ADDITIVE, 0.1, &"upgrade"))
	print(%Player.stats.fire_rate.value)
