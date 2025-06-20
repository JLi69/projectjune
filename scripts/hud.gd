extends CanvasLayer

@export var progress_bar_gradient: Gradient

func _ready() -> void:
	$Control/InfoText.text = ""

func activate_finish_screen():
	$Control/Finishscreen.activate()

func _process(_delta: float) -> void:
	if $Control/Finishscreen.visible:
		return
	
	# Open pause menu for lawn
	if Input.is_action_just_pressed("ui_cancel") and $/root/Main.lawn_loaded:
		toggle_lawn_pause_menu()

# used for pop up messages to provide information to the player
func update_info_text(text: String) -> void:
	$Control/InfoText.text = text

func toggle_lawn_pause_menu():
	$Control/PauseMenu.visible = !$Control/PauseMenu.visible
	get_tree().paused = $Control/PauseMenu.visible

# updates progress bar based on the given percent (0.0 to 1.0)
func update_progress_bar(percent: float) -> void:
	# used for the neighborhood
	if percent < 0.0:
		$Control/ProgressBar.hide()
		return
	else:
		$Control/ProgressBar.show()
		$Control/ProgressBar.size.x = percent * $Control/ProgressBar/ProgressBackground.size.x
		$Control/ProgressBar.color = progress_bar_gradient.sample(percent)
		$Control/ProgressBar/ProgressBarPercent.text = str(int(percent * 100)) + "%"

func update_day_counter(days: int):
	$Control/DayLabel.text = "Day %d" % days

func update_money_counter(money: int):
	$Control/MoneyLabel.text = "$%d/500" % money

func set_neighbor_menu(neighbor: AnimatedSprite2D) -> void:
	$Control/NeighborMenu.set_menu(neighbor)

func hide_neighbor_menu() -> void:
	$Control/NeighborMenu.hide_menu()
