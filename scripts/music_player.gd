extends Node

@export var party_level = 1
@export var interact_level = 1
@export var tarnsition_strength : float = 2.2
## 0 for no music. 1 for menu. 2 for party. 3 for interact
var current_music := 0

@onready var party: Node = $Party
@onready var party_pads: AudioStreamPlayer = $Party/PartyPads
@onready var party_drums: AudioStreamPlayer = $Party/PartyDrums
@onready var party_bass: AudioStreamPlayer = $Party/PartyBass
@onready var party_arp: AudioStreamPlayer = $Party/PartyARP

@onready var interact: Node = $Interact
@onready var topper: AudioStreamPlayer = $Interact/Topper
@onready var bass: AudioStreamPlayer = $Interact/Bass
@onready var bass_2: AudioStreamPlayer = $Interact/Bass2
@onready var wawa: AudioStreamPlayer = $Interact/Wawa
@onready var kick: AudioStreamPlayer = $Interact/Kick
@onready var beat: AudioStreamPlayer = $Interact/Beat
@onready var vox: AudioStreamPlayer = $Interact/Vox
@onready var fx: AudioStreamPlayer = $Interact/FX

@onready var alienated_mainmenu: AudioStreamPlayer = $MainMenu/AlienatedMainmenu

func stop_music():
	current_music = 0

func play_main_menu():
	current_music = 1

func play_party():
	current_music = 2

func play_interact():
	current_music = 3

func _process(delta: float) -> void:
	match current_music:
		0:
			alienated_mainmenu.volume_linear = 0.0
			for i in party.get_children():
				i.volume_linear = 0.0
			for i in interact.get_children():
				i.volume_linear = 0.0
		1:
			alienated_mainmenu.volume_linear = lerp(alienated_mainmenu.volume_linear, 1.0, delta * tarnsition_strength)
			for i in party.get_children():
				i.volume_linear = lerp(i.volume_linear, 0.0, delta * tarnsition_strength)
			for i in interact.get_children():
				i.volume_linear = lerp(i.volume_linear, 0.0, delta * tarnsition_strength)
		2:
			alienated_mainmenu.volume_linear = lerp(alienated_mainmenu.volume_linear, 0.0, delta * tarnsition_strength)
			for i in interact.get_children():
				i.volume_linear = lerp(i.volume_linear, 0, delta * tarnsition_strength)
			party_pads.volume_linear = lerp(party_pads.volume_linear, clampf(party_level, 0.0, 1.0), delta * tarnsition_strength)
			party_drums.volume_linear = lerp(party_drums.volume_linear, clampf(party_level, 0.0, 1.0), delta * tarnsition_strength)
			party_bass.volume_linear = lerp(party_bass.volume_linear, clampf(party_level - 1.0, 0.0, 1.0), delta * tarnsition_strength)
			party_arp.volume_linear = lerp(party_arp.volume_linear, clampf(party_level - 2.0, 0.0, 1.0), delta * tarnsition_strength)
		3:
			alienated_mainmenu.volume_linear = lerp(alienated_mainmenu.volume_linear, 0.0, delta * tarnsition_strength)
			for i in party.get_children():
				i.volume_linear = lerp(i.volume_linear, 0.0, delta * tarnsition_strength)
			topper.volume_linear = lerp(topper.volume_linear, clampf(interact_level, 0.0, 7.0), delta * tarnsition_strength)
			bass.volume_linear = lerp(bass.volume_linear, clampf(interact_level, 0.0, 7.0), delta * tarnsition_strength)
			bass_2.volume_linear = lerp(bass_2.volume_linear, clampf(interact_level - 2, 0.0, 7.0), delta * tarnsition_strength)
			wawa.volume_linear = lerp(wawa.volume_linear, clampf(interact_level - 2, 0.0, 7.0), delta * tarnsition_strength)
			kick.volume_linear = lerp(kick.volume_linear, clampf(interact_level - 2, 0.0, 7.0), delta * tarnsition_strength)
			beat.volume_linear = lerp(beat.volume_linear, clampf(interact_level - 4, 0.0, 7.0), delta * tarnsition_strength)
			vox.volume_linear = lerp(vox.volume_linear, clampf(interact_level - 4, 0.0, 7.0), delta * tarnsition_strength)
			fx.volume_linear = lerp(fx.volume_linear, clampf(interact_level - 4, 0.0, 7.0), delta * tarnsition_strength)
