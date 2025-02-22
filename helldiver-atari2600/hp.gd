extends Label

func _physics_process(_delta: float) -> void:
	self.text="HP:"+str(get_parent().get_parent().health)
