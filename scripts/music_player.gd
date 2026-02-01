extends Node

@export var party_level = 1
@export var interact_level = 1
@export var tarnsition_strength : float = 2.2
## 0 for no music. 1 for menu. 2 for party. 3 for interact
var current_music := 0

@onready var party: Node = $Party
@onready var party_pads: AudioStreamPlayer = $Interact/PartyPads
@onready var party_drums: AudioStreamPlayer = $Interact/PartyDrums
@onready var party_bass: AudioStreamPlayer = $Interact/PartyBass
@onready var party_arp: AudioStreamPlayer = $Interact/PartyARP

@onready var interact: Node = $Interact
@onready var topper: AudioStreamPlayer = $Party/Topper
@onready var bass: AudioStreamPlayer = $Party/Bass
@onready var bass_2: AudioStreamPlayer = $Party/Bass2
@onready var wawa: AudioStreamPlayer = $Party/Wawa
@onready var kick: AudioStreamPlayer = $Party/Kick
@onready var beat: AudioStreamPlayer = $Party/Beat
@onready var vox: AudioStreamPlayer = $Party/Vox
@onready var fx: AudioStreamPlayer = $Party/FX

@onready var alienated_mainmenu: AudioStreamPlayer = $MainMenu/AlienatedMainmenu

func play_main_menu():
	current_music = 1

func play_party():
	current_music = 2

func play_interact():
	current_music = 3

func _process(delta: float) -> void:
	match current_music:
		0:
			alienated_mainmenu.volume_linear = 0
			for i in party.get_children():
				i.volume_linear = 0
			for i in interact.get_children():
				i.volume_linear = 0
		1:
			alienated_mainmenu.volume_linear = lerp(alienated_mainmenu.volume_linear, 1, delta)
			for i in party.get_children():
				i.volume_linear = lerp(i.volume_linear, 0, delta)
			for i in interact.get_children():
				i.volume_linear = lerp(i.volume_linear, 0, delta)
		2:
			alienated_mainmenu.volume_linear = lerp(alienated_mainmenu.volume_linear, 0, delta)
			for i in party.get_children():
				i.volume_linear = lerp(i.volume_linear, 0, delta)
			for i in interact.get_children():
				i.volume_linear = lerp(i.volume_linear, 0, delta)
