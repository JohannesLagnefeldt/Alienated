extends Node2D

@onready var timer: Timer = $Timer
@onready var character_changer: AnimationPlayer = $CharacterChanger
@onready var timer_2: Timer = $Timer2

var state : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character_changer.play("MercuryEnter")
	Signals.connect("alien_change", change_alien)
	timer_2.start()

func change_alien():
	state += 1;
	match state:
		1:
			character_changer.play_backwards("MercuryEnter")
			timer.start()
		2:
			character_changer.play_backwards("EyeEnter")
			timer.start()

		
				

func _on_timer_timeout() -> void:
	match state:
			1:
				character_changer.play("EyeEnter")
			2:
				character_changer.play("GravityEnter")
	print("time1")			
	timer_2.start()


func _on_timer_2_timeout() -> void:
	print("time2")
	Signals.emit_signal("show_masks")
