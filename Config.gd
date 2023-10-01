extends Panel

var selection = 0
var menuoptions = 3

func _ready():
	$audiolevel.value = GameController.get_sound_vol()
	$musiclevel.value = GameController.get_music_vol()
	update_markers()

func _input(event):
	if(!visible):
		return
	if event.is_action_pressed("input_down") || event.is_action_pressed("input_select"):
		selection +=1
		if selection == menuoptions:
			selection = 0
		update_markers()
	if event.is_action_pressed("input_up"):
		selection -= 1
		if selection < 0:
			selection = menuoptions -1
		update_markers()
	if event.is_action_pressed("input_a") || event.is_action_pressed("input_b") || event.is_action_pressed("input_start"):
		item_select()
	if event.is_action_pressed("input_right"):
		set_vol_up()
	if event.is_action_pressed("input_left"):
		set_vol_down()

func update_markers():
	$marker1.hide()
	$marker2.hide()
	$marker3.hide()
	match selection:
		0:
			$marker1.show()
		1:
			$marker2.show()
		2:
			$marker3.show()

func set_vol_up():
	match selection:
		0:
			$audiolevel.value += 0.1
			GameController.set_sound_vol($audiolevel.value)
			$Audio.play()
		1:
			$musiclevel.value += 0.1
			GameController.set_music_vol($musiclevel.value)

func set_vol_down():
	match selection:
		0:
			$audiolevel.value -= 0.1
			GameController.set_sound_vol($audiolevel.value)
			$Audio.play()
		1:
			$musiclevel.value -= 0.1
			GameController.set_music_vol($musiclevel.value)

func item_select():
	if(selection == 2):
		get_parent().toggle_settings()
