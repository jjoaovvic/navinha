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
	%Player.MAX_BOOST += 10
	print(%Player.MAX_BOOST)

func faster_shoot():
	%Player.BULLET_TIME -= %Player.BULLET_TIME
	print(%Player.BULLET_TIME)
