extends Label

func _physics_process(_delta: float) -> void:
	self.text="SCORE:"+str(get_parent().get_parent().score)
	
