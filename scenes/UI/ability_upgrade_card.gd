extends PanelContainer

signal selected()

@onready var name_label: Label = %NameLabel
@onready var desc_label: Label = %DescLabel

var disabled: bool = false

func _ready():
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)


func play_in(delay: float = 0):
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	$AnimationPlayer.play("In")


func play_discard():
	$AnimationPlayer.play("Discard")


func select_card():
	disabled = true
	$AnimationPlayer.play("Selected")
	
	for other_card in get_tree().get_nodes_in_group("upgrade_card"):
		if other_card == self:
			continue
		
		other_card.play_discard()
	
	await $AnimationPlayer.animation_finished
	selected.emit()


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	desc_label.text = upgrade.description


func on_gui_input(event: InputEvent):
	if disabled:
		return
	
	if event.is_action_pressed("left_click"):
		select_card()


func on_mouse_entered():
	if disabled:
		return
	
	$HoverAnimPlayer.play("hover")
