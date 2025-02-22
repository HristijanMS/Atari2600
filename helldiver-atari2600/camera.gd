extends Camera2D


const SCREEN_SIZE := Vector2(300, 160)
var cur_screen := Vector2( 0, 0 )

func _ready()->void:
	set_as_top_level( true )
	global_position = get_parent().global_position
	_update_screen( cur_screen )

func _physics_process(_delta:float)->void:
	var parent_screen : Vector2 = ( get_parent().global_position / SCREEN_SIZE ).floor()
	if not parent_screen.is_equal_approx( cur_screen ):
		_update_screen( parent_screen )


func _update_screen( new_screen : Vector2 )->void:
	cur_screen = new_screen
	global_position = cur_screen * SCREEN_SIZE + SCREEN_SIZE * 0.5
