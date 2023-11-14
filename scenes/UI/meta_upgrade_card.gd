extends PanelContainer

@onready var name_label: Label = %NameLabel
@onready var desc_label: Label = %DescLabel
@onready var progress_bar = %ProgressBar
@onready var purchase_button = %PurchaseButton
@onready var progress_label = %ProgressLabel
@onready var count_label = %CountLabel

var upgrade: MetaUpgrade

func _ready():
	purchase_button.pressed.connect(on_purchase_pressed)


func set_meta_upgrade(upgrade: MetaUpgrade):
	self.upgrade = upgrade
	name_label.text = upgrade.title
	desc_label.text = upgrade.description
	update_progress()


func update_progress():
	var current_currency = MetaProgression.save_data["meta_upgrades_currency"]
	var percent = current_currency / upgrade.experience_cost
	var current_upgrade_quantity = 0
	var is_maxed = current_upgrade_quantity >= upgrade.max_quantity
	
	if MetaProgression.save_data["meta_upgrades"].has(upgrade.id):
		current_upgrade_quantity = MetaProgression.save_data["meta_upgrades"][upgrade.id]["quantity"]
	
	percent = min(percent, 1)
	progress_bar.value = percent
	progress_label.text = str(current_currency) + ' / ' + str(upgrade.experience_cost)
	count_label.text = "x%d" % current_upgrade_quantity
	purchase_button.disabled = percent < 1 || is_maxed
	if is_maxed:
		purchase_button.text = "MAX"


func on_purchase_pressed():
	if self.upgrade == null:
		return
	
	MetaProgression.add_meta_upgrade(self.upgrade)
	MetaProgression.save_data["meta_upgrades_currency"] -= upgrade.experience_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_card", "update_progress")
	$AnimationPlayer.play("Selected")
