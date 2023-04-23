extends Control

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().paused = !get_tree().paused
		self.visible = !self.visible
		if !self.visible:
			return
		
		$Saving.visible = true
		$Saving.text = "Saving..."
		$Loading.loading = true
		$/root/Game.save()
		$Loading.loading = false
		$Saving.text = "Game saved"
		await get_tree().create_timer(2).timeout
		$Saving.visible = false

func _on_resume_pressed():
	get_tree().paused = false
	self.visible = false

func _on_exit_pressed():
	$/root/Menu/Music.play()
	$/root/Menu.visible = true
	$/root/Game.queue_free()
	$/root/Menu/Camera2D.make_current()
	get_tree().paused = false
