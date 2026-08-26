extends CanvasLayer
class_name StatsOverlay

@export var stats_component: StatsComponent
@export var toggle_key := KEY_F3

@onready var _label: Label = %DebugLabel


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == toggle_key:
			visible = not visible
			get_viewport().set_input_as_handled()


func _process(_delta: float) -> void:
	if not visible or stats_component == null or stats_component.stats == null:
		return
	_label.text = _render(stats_component.stats)


func _render(stats: ShipStats) -> String:
	var lines := PackedStringArray()
	lines.append("STATS  [F3]")
	var health := stats.health
	lines.append("%-16s %7.1f / %.1f" % ["health", health.current, health.maximum.value])
	lines.append(_stat_line("max_health", health.maximum))
	lines.append(_stat_line("regen", health.regen))
	# Reflexao para que um stat novo apareca sozinho, sem editar este arquivo.
	for prop in stats.get_property_list():
		var value = stats.get(prop["name"])
		if value is Stat:
			lines.append(_stat_line(prop["name"], value))
	return "\n".join(lines)


func _stat_line(stat_name: String, stat: Stat) -> String:
	var line := "%-16s %7.2f" % [stat_name, stat.value]
	var mods := _modifiers(stat)
	if mods != "":
		line += "   = %.2f %s" % [stat.base_value, mods]
	return line


func _modifiers(stat: Stat) -> String:
	var parts := PackedStringArray()
	for modifier in stat.buffs.modifiers:
		parts.append(_describe(modifier))
	for modifier in stat.debuffs.modifiers:
		parts.append(_describe(modifier))
	return " ".join(parts)


func _describe(modifier: StatModifier) -> String:
	var origin := "" if modifier.source == &"" else "[%s]" % modifier.source
	match modifier.kind:
		StatModifier.Kind.FLAT:
			return "%+.1f%s" % [modifier.amount, origin]
		StatModifier.Kind.ADDITIVE:
			return "%+.0f%%add%s" % [modifier.amount * 100.0, origin]
		_:
			return "%+.0f%%mul%s" % [modifier.amount * 100.0, origin]
