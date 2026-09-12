extends Button

var upgrade: Upgrade


func set_upgrade(new_upgrade: Upgrade) -> void:
	upgrade = new_upgrade
	text = upgrade.title


func call_upgrade(stats: ShipStats) -> void:
	upgrade.apply(stats)
